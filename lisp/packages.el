;; packages
(require 'package)
(package-activate-all)
(add-to-list 'package-archives '("MELPA" . "http://melpa.org/packages/"))
(setq package-install-upgrade-built-in nil)
(require 'use-package)
(setq use-package-always-ensure t)

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :custom (markdown-command "pandoc"))

(use-package fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color=base16 --print-query --margin=1,0 --no-hscroll --ansi"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH --color=always"
        fzf/grep-command "grep -nrH --color=always"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/maximize t
        fzf/position-bottom nil
        fzf/window-height 15))

(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" . 'mc/edit-lines)
   ("C->"         . 'mc/mark-next-like-this)
   ("C-<"         . 'mc/mark-previous-like-this)
   ("C-c C-<"     . 'mc/mark-all-like-this)
   ("C-\""        . 'mc/skip-to-next-like-this)
   ("C-:"         . 'mc/skip-to-previous-like-this)))

(use-package corfu
  :hook
  (after-init . global-corfu-mode))

(use-package eglot
  :custom
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider
                                       :signatureHelpProvider
                                       :documentHighlightProvider
                                       :documentFormattingProvider
                                       :inlayHintProvider
                                       :codeActionProvider))
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode c-ts-mode c++-ts-mode) .
                                        ("clangd"
                                         "--header-insertion=never"
                                         "--header-insertion-decorators=0")))
  (add-to-list 'eglot-server-programs '((rust-mode) . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '((zig-mode) . ("zls"))))

(use-package zig-mode
  :demand t)

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
                            "* %i%?\n %U")))
  (org-refile-targets '(("~/Documents/gtd/gtd.org" :maxlevel . 3)
                        ("~/Documents/gtd/someday.org" :level . 1)
                        ("~/Documents/gtd/tickler.org" :maxlevel . 2)))
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (org-agenda-follow-indirect t)
  (org-agenda-start-with-follow-mode t)
  :bind
  (:map org-mode-map
        ("SPC" . nil)
        ("<normal-state> SPC" . nil)
        ("<normal-state> SPC c $" . 'org-archive-subtree)
        ("<normal-state> SPC c #" . 'org-update-statistics-cookies)
        ("<normal-state> SPC c ," . 'org-priority)
        ("<normal-state> SPC c l" . 'org-insert-link)
        ("<normal-state> SPC c t" . 'org-todo)
        ("<normal-state> SPC c w" . 'org-refile)
        ("<normal-state> SPC c ." . 'org-timestamp)
        ("<normal-state> SPC c d" . 'org-deadline)
        ("<normal-state> SPC c s" . 'org-schedule)
        )
)

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
  :demand t
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))

(use-package marginalia
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

(use-package whitespace
  :hook
  (prog-mode . (lambda () (whitespace-mode 1))))

(use-package evil
  :bind
  :init
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode t)
  :custom
  (evil-undo-system 'undo-redo)
  :hook
  (after-init . evil-mode)
  :config
  (define-prefix-command 'my-leader-map)
  (keymap-set evil-motion-state-map "SPC" 'my-leader-map)
  (keymap-set evil-normal-state-map "SPC" 'my-leader-map)
  (keymap-set evil-insert-state-map "C-n" nil)
  (keymap-set evil-insert-state-map "C-p" nil)
  (define-key my-leader-map "fo" 'find-file)
  (define-key my-leader-map "fs" 'save-buffer)
  (define-key my-leader-map "fw" 'write-file)
  (define-key my-leader-map "bs" 'switch-to-buffer)
  (define-key my-leader-map "bk" 'kill-buffer)
  (define-key my-leader-map "br" 'rename-buffer)
  (define-key my-leader-map "bq" 'quit-window)
  (define-key my-leader-map "ts0" 'text-scale-adjust)
  (define-key my-leader-map "ts=" 'text-scale-adjust)
  (define-key my-leader-map "ts-" 'text-scale-adjust)
  (define-key my-leader-map "p" project-prefix-map)
  (define-key my-leader-map "oa" 'org-agenda)
  (define-key my-leader-map "oc" 'org-capture)
  (define-key my-leader-map "m" 'magit)
  (define-key my-leader-map "cp" cape-prefix-map)
 )

(use-package evil-collection
  :config
  (evil-collection-init '(org-agenda org dired magit help compile)))

(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
        ("SPC" . nil)
        ("<normal-state> SPC" . nil)))

(use-package help
  :ensure nil
  :bind
  (:map help-mode-map
        ("SPC" . nil)
        ("<normal-state> SPC" . nil)))
