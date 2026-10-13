;; -*- lexical-binding: t; -*-
(load custom-file)
(load "custom-lisp.el")

(require 'package)
(require 'use-package)
(package-activate-all)
(add-to-list 'package-archives '("MELPA" . "http://melpa.org/packages/"))
(setq package-install-upgrade-built-in nil)

;;; misc
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)
(setq imenu-flatten 'annotation)
(setq isearch-repeat-on-direction-change t)
(setq comint-inhibit-carriage-motion nil)
(setq-default buffer-file-coding-system 'utf-8-unix)

;;; mode-line
(setq-default mode-line-format '("%e" mode-line-front-space
                                 (:propertize
                                  ("" mode-line-client mode-line-modified mode-line-remote
                                   mode-line-window-dedicated))
                                 "  %b"
                                 mode-line-format-right-align
                                 mode-line-misc-info
                                 (project-mode-line project-mode-line-format)
                                 " "
                                 (vc-mode vc-mode)
                                 "  "
                                 mode-name
                                 mode-line-process
                                 " "
                                 ))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-search-module 'evil-search)
  :custom
  (evil-undo-system 'undo-redo)
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-cjk-emacs-word-boundary t)
  :hook
  (after-init . evil-mode)
  :config
  (advice-add #'evil-ex-search-word-backward :around #'evil-ex-search-word-backward-advice)
  (advice-add #'evil-ex-search-word-forward :around #'evil-ex-search-word-forward-advice)
  (advice-add #'evil-ex-search-setup :after #'evil-ex-start-search-with-region-string)
  (advice-add #'forward-evil-word :around #'my/c-forward-evil-word)
  (advice-add #'forward-evil-WORD :around #'my/c-forward-evil-WORD)
  (define-prefix-command 'my-leader-map)
  (keymap-set evil-motion-state-map "SPC" 'my-leader-map)
  (keymap-set evil-normal-state-map "SPC" 'my-leader-map)
  (keymap-set evil-motion-state-map "C-w o" #'toggle-delete-other-windows)
  (keymap-set evil-insert-state-map "C-n" nil)
  (keymap-set evil-insert-state-map "C-p" nil)
  (define-key my-leader-map "fo" 'find-file)
  (define-key my-leader-map "fs" 'save-some-buffers)
  (define-key my-leader-map "fw" 'write-file)
  (define-key my-leader-map "bs" 'switch-to-buffer)
  (define-key my-leader-map "bk" 'kill-buffer)
  (define-key my-leader-map "br" 'rename-buffer)
  (define-key my-leader-map "bq" 'quit-window)
  (define-key my-leader-map "ts0" 'text-scale-adjust)
  (define-key my-leader-map "ts=" 'text-scale-adjust)
  (define-key my-leader-map "ts-" 'text-scale-adjust)
  (define-key my-leader-map "p" project-prefix-map)
  (define-key my-leader-map "m" 'magit)
 )

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init '(org-agenda org dired magit help compile xref)))

(use-package completion-preview
  :custom
  (completion-preview-minimum-symbol-length 3)
  (completion-preview-idle-delay 0.2)
  :bind
  (:map completion-preview-active-mode-map
        ("C-n" . #'completion-preview-next-candidate)
        ("C-p" . #'completion-preview-prev-candidate))
  :hook
  (after-init . global-completion-preview-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :custom (markdown-command "pandoc")
  :hook
  (markdown-mode . auto-fill-mode))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-c C-S-c" . 'mc/edit-lines)
   ("C->"         . 'mc/mark-next-like-this)
   ("C-<"         . 'mc/mark-previous-like-this)
   ("C-c C-<"     . 'mc/mark-all-like-this)
   ("C-\""        . 'mc/skip-to-next-like-this)
   ("C-:"         . 'mc/skip-to-previous-like-this)))

(use-package corfu
  :ensure t
  :hook
  (after-init . global-corfu-mode))

(use-package eglot
  :custom
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider
                                       :signatureHelpProvider
                                       :documentHighlightProvider
                                       :inlayHintProvider
                                       :codeActionProvider
                                       :semanticTokensProvider))
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode c-ts-mode c++-ts-mode) .
                                        ("clangd"
                                         "--header-insertion=never"
                                         "--header-insertion-decorators=0")))
  (add-to-list 'eglot-server-programs '((rust-mode) . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '((zig-mode) . ("zls"))))

(use-package zig-mode
  :ensure t
  :config
  (advice-add 'zig--run-cmd :around
            (lambda (f cmd &optional source &rest args)
              (apply f cmd source (append '("--color" "off") args))))
  :hook
  (zig-mode . subword-mode))

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-startup-folded t)
  (org-agenda-todo-list-sublevels nil)
  (org-agenda-files '("~/Documents/gtd/inbox.org"
                      "~/Documents/gtd/gtd.org"
                      "~/Documents/gtd/tickler.org"))
  (org-capture-templates '(("t" "Todo [inbox]" entry
                            (file+headline "~/Documents/gtd/inbox.org" "Tasks")
                            "* TODO %i%?")
                           ("T" "Tickler" entry
                            (file+headline "~/Documents/gtd/tickler.org" "Tickler")
                            "* %i%?\n  %U")
                           ("n" "Note" entry
                            (file+headline "~/Documents/gtd/notes.org" "Notes")
                            "* %i%?\n  %U")))
  (org-refile-targets '(("~/Documents/gtd/gtd.org" :maxlevel . 3)
                        ("~/Documents/gtd/someday.org" :level . 1)
                        ("~/Documents/gtd/tickler.org" :maxlevel . 2)
                        ("~/Documents/gtd/notes.org" :maxlevel . 3)))
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (org-agenda-follow-indirect nil)
  (org-agenda-start-with-follow-mode nil)
  :config
  (define-key my-leader-map "oa" 'org-agenda)
  (define-key my-leader-map "oc" 'org-capture)
  (define-key my-leader-map "os" 'org-store-link)
  (evil-define-key 'normal org-mode-map (kbd "SPC c $") 'org-archive-subtree)
  (evil-define-key 'normal org-mode-map (kbd "SPC c $") 'org-archive-subtree)
  (evil-define-key 'normal org-mode-map (kbd "SPC c #") 'org-update-statistics-cookies)
  (evil-define-key 'normal org-mode-map (kbd "SPC c ,") 'org-priority)
  (evil-define-key 'normal org-mode-map (kbd "SPC c l") 'org-insert-link)
  (evil-define-key 'normal org-mode-map (kbd "SPC c t") 'org-todo)
  (evil-define-key 'normal org-mode-map (kbd "SPC c w") 'org-refile)
  (evil-define-key 'normal org-mode-map (kbd "SPC c .") 'org-timestamp)
  (evil-define-key 'normal org-mode-map (kbd "SPC c d") 'org-deadline)
  (evil-define-key 'normal org-mode-map (kbd "SPC c s") 'org-schedule)
  (evil-define-key 'normal org-mode-map (kbd "SPC c &") 'org-mark-ring-goto)
  (evil-define-key 'normal org-mode-map (kbd "SPC c o") 'org-open-at-point)
  (evil-define-key 'normal org-mode-map (kbd "SPC c c k") 'org-up-element)
  (evil-define-key 'normal org-mode-map (kbd "SPC c c j") 'org-down-element)
  (evil-define-key 'normal org-mode-map (kbd "SPC c c h") 'org-backward-heading-same-level)
  (evil-define-key 'normal org-mode-map (kbd "SPC c c l") 'org-forward-heading-same-level)
  :hook
  (org-mode . auto-fill-mode))

(use-package dabbrev
  :bind (("M-/"   . completion-at-point)
         ("C-M-/" . dabbrev-expand))
  :custom
  (dabbrev-case-fold-search nil)
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'authinfo-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))

(use-package marginalia
  :ensure t
  :bind
  (:map minibuffer-local-map
        ("M-A" . marginalia-cycle))
  :hook
  (after-init . marginalia-mode))

(use-package tramp
  :defer t
  :custom
  (tramp-terminal-type "dumb")
  (remote-file-name-inhibit-locks t)
  (tramp-use-scp-direct-remote-copying t)
  (remote-file-name-inhibit-auto-save-visited t)
  :config
  (when (eq system-type 'windows-nt)
    (setq tramp-default-method "plink")))

(use-package savehist
  :hook
  (after-init . savehist-mode))

(use-package winner
  :hook
  (after-init . winner-mode))

(use-package whitespace
  :ensure t
  :hook
  (prog-mode . (lambda () (whitespace-mode 1))))

(use-package dired
  :custom
  (dired-listing-switches "-Alh")
  (dired-dwim-target 1)
  :bind
  (:map dired-mode-map
        ("SPC" . nil)
        ("<normal-state> SPC" . nil))
  :hook
  (dired-mode . (lambda () (setq truncate-lines t))))

(use-package help
  :bind
  (:map help-mode-map
        ("SPC" . nil)
        ("<normal-state> SPC" . nil)))

(use-package emacs
  :bind
  (("<f5>" . 'compile)
   ("RET" . 'newline-and-indent))
  (:map minibuffer-local-filename-completion-map
        ("C-l" . #'up-directory))
  :custom
  (tab-width 8)
  (indent-tabs-mode nil)
  (bidi-paragraph-direction 'left-to-right)
  (enable-recursive-minibuffers t)
  (align-to-tab-stop nil)
  (tab-always-indent t)
  (truncate-lines t)
  (scroll-preserve-screen-position t)
  (redisplay-skip-fontification-on-input t)
  (read-process-output-max (* 4 1024 1024))
  (save-interprogram-paste-before-kill t)
  (kill-do-not-save-duplicates t)
  (help-window-select t)
  (fill-column 80)
  :hook
  (emacs-startup . (lambda () (setq gc-cons-threshold (* 50 1024 1024)))))

(use-package which-key
  :hook
  (after-init . which-key-mode))

(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'relative)
  (display-line-numbers-current-absolute t)
  (display-line-numbers-width-start t)
  :hook
  (after-init . global-display-line-numbers-mode))

(use-package icomplete
  :custom
  (icomplete-show-matches-on-no-input t)
  :bind
  (:map icomplete-minibuffer-map
        ("RET" . icomplete-fido-exit)
        ("TAB" . icomplete-force-complete))
  :hook
  (icomplete-minibuffer-setup . (lambda () (setq truncate-lines t)))
  (after-init . icomplete-vertical-mode))

(use-package compile
  :custom
  (compilation-scroll-output 'first-error)
  (compile-command nil)
  (compilation-disable-input t)
  :hook
  (compilation-filter . ansi-color-compilation-filter)
  :config
  (add-to-list 'compilation-environment "NO_COLOR"))

(use-package project
  :custom
  (project-file-history-behavior 'relativize)
  (project-mode-line nil))

(use-package cc-mode
  :custom
  (c-basic-offset tab-width)
  :hook
  (c-mode . (lambda () (electric-indent-mode -1)))
  (c++-mode . (lambda () (electric-indent-mode -1)))
  :config
  (c-add-style "openbsd"
               '("bsd"
                 (c-backspace-function . delete-backward-char)
                 (c-syntactic-indentation-in-macros . nil)
                 (c-tab-always-indent . t)
                 (c-auto-align-backslashes . nil)
                 (c-hanging-braces-alist
                  (block-close . c-snug-do-while))
                 (c-offsets-alist
                  (arglist-cont-nonempty . *)
                  (statement-cont . *))
                 (indent-tabs-mode . t)))
  (setq c-default-style "openbsd"))

(use-package magit
  :ensure t
  :demand t
  :custom
  (magit-commit-show-diff nil)
  (shell-command-with-editor-mode t)
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
  :bind
  (:map magit-mode-map ("SPC" . nil)))

;;; buffer names
(use-package uniquify
  :custom
  (uniquify-buffer-name-style 'forward))

;;; grep
(use-package grep
  :custom
  ;; (grep-command "grep --color=always -nH -r ")
  (grep-command "rg --no-heading --color=always -nH ")
  (grep-use-null-device nil))
