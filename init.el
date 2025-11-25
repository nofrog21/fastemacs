;; startup
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq custom-file "custom.el")
(load custom-file)
(add-to-list 'default-frame-alist
			 `(font . "IosevkaFixed Nerd Font Extended 13"))
(add-to-list 'default-frame-alist `(fullscreen . maximized))
(load-theme 'gruber-darker t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(savehist-mode 1)

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

;; completions
(icomplete-vertical-mode 1)
(keymap-set icomplete-minibuffer-map "TAB" #'icomplete-force-complete)
(setq completion-category-overrides
   '((buffer
	  (styles . (basic flex))
	  (cycle  . 10))
	 (file
	  (styles . (initials flex))
	  (cycle  . 10))
	 (symbol-help
	  (styles basic shorthand substring))))
(setq completion-auto-select nil)
(setq completion-show-help nil)
(setq completion-auto-help nil)
(setq completions-sort 'historical)
(setq icomplete-show-matches-on-no-input t)
(setq minibuffer-completion-auto-choose nil)
(add-to-list 'completion-ignored-extensions "./")
(add-to-list 'completion-ignored-extensions "../")

(setq dired-listing-switches "-Alh")
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)
(setq imenu-flatten 'annotation)

;;modeline
(setq-default mode-line-format '("%e" mode-line-front-space
								 (:propertize
								  ("" mode-line-mule-info mode-line-client
								   mode-line-modified
								   mode-line-remote mode-line-window-dedicated)
								  display (min-width (6.0)))
								 mode-line-frame-identification
								 mode-line-buffer-identification
								 "  "
								 (project-mode-line project-mode-line-format)
								 (vc-mode vc-mode)
								 "	" 
								 mode-name
								 mode-line-process
								 mode-line-end-spaces))

(defun up-directory (arg)
  "Move up a directory (delete backwards to /)."
  (interactive "p")
  (if (string-match-p "/." (minibuffer-contents))
	  (zap-up-to-char (- arg) ?/)
	(delete-minibuffer-contents)))

;; c-ts-mode
(require 'c-ts-mode)
(setq major-mode-remap-alist '((c-mode . c-ts-mode) (c++-mode . c++-ts-mode)))
(add-hook 'after-change-major-mode-hook (lambda () (electric-indent-mode -1)))
(setq-default c-ts-mode-indent-offset 4)
(setq-default c-ts-mode-indent-style 'bsd)
(add-hook 'c-ts-mode-hook   (lambda () (setq-local indent-tabs-mode nil)))
(add-hook 'c++-ts-mode-hook (lambda () (setq-local indent-tabs-mode nil)))

;; c-mode
(setq-default c-basic-offset 4)
(setq-default c-default-style "bsd")
(add-hook 'c-mode-hook   (lambda () (setq-local indent-tabs-mode nil)))
(add-hook 'c++-mode-hook (lambda () (setq-local indent-tabs-mode nil)))

;; buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'nil)

(setq isearch-repeat-on-direction-change t)

;; keybindings
(keymap-set minibuffer-local-filename-completion-map
			"C-l" #'up-directory)
(global-set-key (kbd "C-x C-/") 'goto-last-change)

(load "packages.el")
