;; startup
(add-to-list 'custom-theme-load-path "gruber-darker-theme.el")
(add-to-list 'default-frame-alist `(font . "IosevkaFixed Nerd Font Extended 14"))
(add-to-list 'default-frame-alist `(fullscreen . maximized))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; globals
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq display-line-numbers-type 'visual)
(setq display-line-numbers-current-absolute t)
(global-display-line-numbers-mode 1)
(setq-default tab-width 4)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq enable-recursize-minibuffers t)

(require 'tramp)
(setq tramp-terminal-type "dumb")
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink"))
(setq remote-file-name-inhibit-locks t
      tramp-use-scp-direct-remote-copying t
      remote-file-name-inhibit-auto-save-visited t)

(setq completion-auto-select nil)
(setq completion-show-help nil)
(setq completion-auto-help nil)
(setq completions-sort 'historical)
(setq dired-listing-switches "-Alh")
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)

(setq custom-file "custom.el")
(load custom-file)
