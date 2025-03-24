;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq user-full-name "Ivan Ponomarenko"
      user-mail-address "ivan.ponomarenko@gmail.com"
      )
;;(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 13)
;;      )
;;      ;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down (that isn't worth an entry in my notes). I can
;; do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq mac-command-modifier 'control ; make cmd key do Control
      mac-option-modifier 'nil ; make opt key do Meta
      mac-right-option-modifier 'meta ; make right option behave normally
      mac-control-modifier 'super ; make Control key do Super
      ns-function-modifier 'hyper  ; make Fn key do Hyper
      )
(setq python-shell-interpreter "/usr/local/bin/python3")

;; Choix du thème
(setq doom-theme 'doom-acario-dark)
;; Police de caractères
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
;;       doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
;;       doom-big-font (font-spec :family "Fira Mono" :size 19))
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default js-indent-level 2)
(setq-default typescript-indent-level 2)
(setq-default web-mode-indent-style 2)
(setq-default web-mode-code-indent-offset 2)

;; Assign typescript-mode to .tsx files
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :config
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))


(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'json-mode-hook 'prettier-js-mode)
(add-hook 'css-mode-hook 'prettier-js-mode)
;; (add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'graphql-mode-hook 'prettier-js-mode)

(add-hook 'after-init-hook 'global-company-mode)

;; Create submodules for multiple major modes
;; (require 'mmm-mode)
;; (setq mmm-global-mode t)
;; (setq mmm-submode-decoration-level 0) ;; Turn off background highlight
;; (setq mmm-parse-when-idle t)

;; Add css mode for CSS in JS blocks
;; (mmm-add-classes
;;  '((mmm-styled-mode
;;     :submode css-mode
;;     :front "\\(styled\\|css\\)[.()<>[:alnum:]]?+`"
;;     :front-offset 1
;;     :back "`;")))

;; (mmm-add-mode-ext-class 'typescript-mode nil 'mmm-styled-mode)

;; ;; Add submodule for graphql blocks
;; (mmm-add-classes
;;  '((mmm-graphql-mode
;;     :submode graphql-mode
;;     :front "gr?a?p?h?ql`" ;; Add additional aliases like `gql` if needed
;;     :back "`;")))

;; (mmm-add-mode-ext-class 'typescript-mode nil 'mmm-graphql-mode)

;; ;; Add JSX submodule, because typescript-mode is not that great at it
;; (mmm-add-classes
;;  '((mmm-jsx-mode
;;     :front "\\(return\s\\|n\s\\|(\n\s*\\)<"
;;     :front-offset -1
;;     :back ">\n?\s*)"
;;     :back-offset 1
;;     :submode web-mode)))

;; (mmm-add-mode-ext-class 'typescript-mode nil 'mmm-jsx-mode)

;; (defun mmm-reapply ()
;;   (mmm-mode)
;;   (mmm-mode))

;; (add-hook 'after-save-hook
;;           (lambda ()
;;             (when (string-match-p "\\.tsx?" buffer-file-name)
;;               (mmm-reapply))))

;; (defadvice find-file (after find-file-sudo activate)
;;   "Find file as root if necessary."
;;   (unless (and buffer-file-name
;;                (file-writable-p buffer-file-name))
;;     (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
(setq display-line-numbers-type nil)
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; lang org
(setq org-directory "~/org/"
      org-mobile-directory "~/Dropbox/Apps/MobileOrg"
      org-mobile-inbox-forpull "~/org/flagged.org"
      org-archive-location (concat org-directory ".archive/%s::")
      org-roam-directory (concat org-directory "notes/")
      org-journal-encrypt-journal t
      org-ellipsis " ▼ "
      org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷")
      org-priority-highest ?A
      org-priority-lowest ?D
      org-priority-default ?D)
;; setq org-fancy-priorities-list '("⚑" "⬆" "■")
;;org-mode
(defvar +org-capture-todo-file "inbox.org"
  "File for capturing all TODO entries")
(defvar +org-capture-tickler-file "tickler.org"
  "File for capturing tickler events")

(after! org
  (setq +org-capture-todo-file
        (expand-file-name +org-capture-todo-file org-directory))
  (setq +org-capture-tickler-file
        (expand-file-name +org-capture-tickler-file org-directory))
  (setq org-log-done t)
  ;; (add-to-list 'org-capture-templates
  ;;              '(("d" "Dream" entry
  ;;                 (file+headline "inbox.org" "Dream")
  ;;                 "* TODO %?\n :PROPERTIES:\n :CATEGORY: dream\n :END:\n %i\n"
  ;;                 :prepend t :kill-buffer t))
  ;;              )
  (add-to-list 'org-capture-templates
               '("T" "Tickler" entry
                 (file+headline +org-capture-tickler-file "Actions")
                 "* %i%? \n %U" :prepend t))
  (add-to-list 'org-capture-templates
               '("O" "OPA Block" entry
                 (file+headline +org-capture-todo-file "OPA")
                 (file "~/org/templates/opa-tmpl.org") :prepend t))
  (add-to-list 'org-capture-templates
               '("V" "Value Extract" entry
                 (file+headline +org-capture-todo-file "Capitalize")
                 (file "~/org/templates/capitalize-tmpl.org") :prepend t))
  )
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda


;; (setq org-agenda-files '("~/org/inbox.org"
;;                          "~/org/projects.org"
;;                          "~/org/tickler.org"))

;; (setq org-capture-templates '(("t" "Todo [inbox]" entry
;;                                (file+headline "~/org/inbox.org" "Tasks")
;;                                "* TODO %i%?")
;;                               ("T" "Tickler" entry
;;                                (file+headline "~/org/tickler.org" "Tickler")
;;                                "* %i%? \n %U")
;;                               ("o" "OPA Block" entry)
;;                               (file+headline "~/org/inbox.org" "OPA")
;;                               (file "~/Dropbox/org/templates/opa-tmpl.org")))
;; (setq org-refile-targets '(("~/org/projects.org" :maxlevel . 3)
;;                            ("~/org/someday.org" :level . 1)
;;                            ("~/org/tickler.org" :maxlevel . 2)))

;;Journal
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

;; Common Lisp
(after! lisp-mode (setq inferior-lisp-program "/usr/local/bin/sbcl"))
;; Fenêtre maximisée
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;;Calendar
(defun calendar-helper () ;; doesn't have to be interactive
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Purple")
    (cfw:ical-create-source "Ivan Ponomarenko gCal" "https://calendar.google.com/calendar/ical/ivan.ponomarenko%40gmail.com/private-853b825c3317ac12f07b1ebcd6a29526/basic.ics" "Blue"))))
(defun calendar-init ()
  ;; switch to existing calendar buffer if applicable
  (if-let (win (cl-find-if (lambda (b) (string-match-p "^\\*cfw:" (buffer-name b)))
                           (doom-visible-windows)
                           :key #'window-buffer))
      (select-window win)
    (calendar-helper)))
(defun =my-calendar ()
  "Activate (or switch to) *my* `calendar' in its workspace."
  (interactive)
  (if (featurep! :ui workspaces) ;; create workspace (if enabled)
      (progn
        (+workspace-switch "Calendar" t)
        (doom/switch-to-scratch-buffer)
        (calendar-init)
        (+workspace/display))
    (setq +calendar--wconf (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (calendar-init)))

(after! org-gcal
  (setq org-gcal-client-id "513422713223-2n1ncflecvrdu400b54b06r71kogl7v1.apps.googleusercontent.com"
        org-gcal-client-secret "eLZ_2d0fiRiGmlGt6m9MOwBg"
        org-gcal-file-alist '(("ivan.ponomarenko@gmail.com" . "~/org/gcal.org")))
  (add-hook 'org-agenda-mode-hook (lambda() (org-gcal-sync)))
  (add-hook 'org-capture-after-initialize-hook (lambda() (org-gcal-sync))))
