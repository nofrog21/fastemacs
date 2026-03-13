(load custom-file)
(load "packages.el")
(load "custom-lisp.el")
(setq ring-bell-function 'ignore)
(setq url-proxy-services '(
			               ("http"  .  "127.0.0.1:10808")
			               ("https" .  "127.0.0.1:10808"))
      )
(setq recenter-redisplay nil)

;;; savehist-mode
(savehist-mode 1)

;;; whitespace-mode
(add-hook 'prog-mode-hook (lambda () (whitespace-mode 1)))

;;; globals
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq display-line-numbers-type 'visual)
(setq display-line-numbers-current-absolute t)
(global-display-line-numbers-mode 1)
(setq-default tab-width 8)
(setq-default indent-tabs-mode nil)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq enable-recursive-minibuffers t)
(setq shell-command-with-editor-mode t)
(setq align-to-tab-stop nil)

;;; trump
(setq tramp-terminal-type "dumb")
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink"))
(setq remote-file-name-inhibit-locks t
      tramp-use-scp-direct-remote-copying t
      remote-file-name-inhibit-auto-save-visited t)

;;; completions
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

;;; misc
(setq dired-listing-switches "-Alh")
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)
(setq imenu-flatten 'annotation)

;;; compilation
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(setq compilation-scroll-output 'first-error)

;;; modeline
(setq-default mode-line-format '("%e" mode-line-front-space
				                 (:propertize
				                  ("" mode-line-mule-info mode-line-client
				                   mode-line-modified
				                   mode-line-remote mode-line-window-dedicated))
				                 "  %b"
				                 "  "
				                 (project-mode-line project-mode-line-format)
				                 (vc-mode vc-mode)
				                 "	"
				                 mode-name
				                 mode-line-process
				                 mode-line-end-spaces))

;;; magit
(setq magit-commit-show-diff nil)

;;; project
(setq project-file-history-behavior 'relativize)

;;; c-ts-mode
;;(require 'c-ts-mode)
;;(setq major-mode-remap-alist '((c++-mode . c++-ts-mode)))
;;(setq-default c-ts-mode-indent-offset 4)
;;(add-hook 'c-ts-mode-hook   (lambda () (setq-local indent-tabs-mode nil)))
;;(add-hook 'c++-ts-mode-hook (lambda () (setq-local indent-tabs-mode nil)))

;; c-mode
;;(add-hook 'after-change-major-mode-hook (lambda () (electric-indent-mode -1)))
(require 'cc-mode)
(add-hook 'c-mode-hook (lambda () (electric-indent-mode 0)))
(add-hook 'c++-mode-hook (lambda () (electric-indent-mode 0)))
(setq-default c-basic-offset tab-width)
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
(setq-default c-default-style "openbsd")

;;; buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'nil)

(setq isearch-repeat-on-direction-change t)

;;; keybindings
(keymap-set minibuffer-local-filename-completion-map
	        "C-l" #'up-directory)
(global-set-key (kbd "C-x C-/") 'goto-last-change)
(keymap-set icomplete-minibuffer-map "RET" 'icomplete-fido-exit)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "M-p")  'move-text-up)
(global-set-key (kbd "M-n")  'move-text-down)


(put 'dired-find-alternate-file 'disabled nil)
