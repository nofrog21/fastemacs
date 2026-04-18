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
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs '((rust-mode) . ("rust-analyzer"))))

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :config
  (org-startup-folded t)
  (org-startup-truncated nil)
  :bind
  ("C-c l" . #'org-store-link)
  ("C-c a" . #'org-agenda)
  ("C-c c" . #'org-capture)
  ("C-c C" . #'org-capture-goto-last-stored))

(use-package dabbrev
  :bind (("C-M-/"   . #'cape-dabbrev)
         ("M-/" . dabbrev-expand))
  :custom
  (dabbrev-case-fold-search nil)
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'authinfo-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package cape
  :bind (("C-c p" . cape-prefix-map)
         ("M-TAB" . completion-at-point))
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

(load "goto-last-change.elc")
