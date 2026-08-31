(load "custom-lisp.el")
(load custom-file)
(load "packages.el")
;;; globals
(use-package emacs
  :custom
  (tab-width 8)
  (indent-tabs-mode nil)
  (bidi-paragraph-direction 'left-to-right)
  (enable-recursive-minibuffers t)
  (align-to-tab-stop nil)
  (tab-always-indent t)
  :config
  (global-visual-line-mode t))

(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'visual)
  (display-line-numbers-current-absolute t)
  :hook
  (after-init . global-display-line-numbers-mode))

;;; misc
(setq dired-listing-switches "-Alh")
(setq dired-dwim-target 1)
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)
(setq imenu-flatten 'annotation)
(setq isearch-repeat-on-direction-change t)

(use-package icomplete
  :custom
  (icomplete-show-matches-on-no-input t)
  :bind
  (:map icomplete-minibuffer-map
        ("RET" . icomplete-fido-exit)
        ("TAB" . icomplete-force-complete))
  :hook
  (after-init . icomplete-vertical-mode))

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
(add-to-list 'completion-ignored-extensions "./")
(add-to-list 'completion-ignored-extensions "../")

;;; grep
(use-package grep
  :custom
  ;; (grep-command "grep --color=always -nH -r ")
  (grep-command "rg --no-heading --color=always -nH ")
  (grep-use-null-device nil))

;;; compilation
(defun display-buffer-compilation-mode-p (buffer-name action)
  "Determine whether BUFFER-NAME is a compilation buffer."
  (with-current-buffer buffer-name
    (or
     (eq 'compilation-mode (buffer-local-value 'major-mode (current-buffer)))
     (string-match (rx "*[Cc]ompilation*")
                   buffer-name))))

(use-package compile
  :custom
  (compilation-scroll-output 'first-error)
  (compile-command nil)
  (compilation-disable-input t)
  :hook
  (compilation-filter . ansi-color-compilation-filter)
  :config
  (add-to-list 'display-buffer-alist '(display-buffer-compilation-mode-p
                                       (display-buffer-at-bottom
                                        display-buffer-in-side-window)
                                       (window-height . 0.25)
                                       (side . bottom)
                                       (slot . -6)))
  (add-to-list 'compilation-environment "TERM=dumb-emacs-ansi"))

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
				 ))

(use-package project
  :custom
  (project-file-history-behavior 'relativize))

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
  :demand t
  :custom
  (magit-commit-show-diff nil)
  (shell-command-with-editor-mode t))

;;; buffer names
(use-package uniquify
  :ensure nil
  :custom
  (uniquify-buffer-name-style 'nil))

;;; keybindings
(keymap-set minibuffer-local-filename-completion-map
	        "C-l" #'up-directory)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "M-p")  'move-text-up)
(global-set-key (kbd "M-n")  'move-text-down)
