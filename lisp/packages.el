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
  (add-to-list 'eglot-server-programs '((rust-mode) . ("rust-analyzer"))))

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :config
  (setq org-startup-folded t)
  (setq org-startup-truncated nil)
  :bind
  ("C-c l" . #'org-store-link)
  ("C-c a" . #'org-agenda)
  ("C-c c" . #'org-capture)
  ("C-c C" . #'org-capture-goto-last-stored))

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
  :bind (("C-c p" . cape-prefix-map)
         )
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster))

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
  :custom
  (evil-undo-system 'undo-redo)
  :hook
  (after-init . evil-mode)
  :config
  (define-key dired-mode-map (kbd "SPC") nil)
  (define-key help-mode-map (kbd "SPC") nil)
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
  (define-key my-leader-map "p" project-prefix-map)
 )

(load "goto-last-change.elc")
