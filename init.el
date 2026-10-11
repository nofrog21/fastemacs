;; -*- lexical-binding: t; -*-
(load custom-file)
;;; misc
(setq font-lock-maximum-deciration 2)
(setq treesit-font-lock-level 2)
(setq imenu-flatten 'annotation)
(setq isearch-repeat-on-direction-change t)
(setq comint-inhibit-carriage-motion nil)
(setq-default buffer-file-coding-system 'utf-8-unix)

;;; completion
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

(setq project-mode-line nil)
(setq-default mode-line-format '("%e" mode-line-front-space
                                 (:propertize
                                  ("" mode-line-client mode-line-modified mode-line-remote
                                   mode-line-window-dedicated))
                                 "  %b"
                                 mode-line-format-right-align
                                 (project-mode-line project-mode-line-format)
                                 " "
                                 (vc-mode vc-mode)
                                 "  "
                                 mode-name
                                 mode-line-process
                                 " "
                                 ))

;;; keybindings
(keymap-set minibuffer-local-filename-completion-map
	        "C-l" #'up-directory)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "RET") 'newline-and-indent)

(load "packages.el")
