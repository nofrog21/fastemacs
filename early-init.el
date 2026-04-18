(add-to-list 'load-path "~/.emacs.d/lisp")
(setq-default custom-file "~/fastemacs/custom.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gruber-darker t)
(add-to-list 'default-frame-alist
	     `(font . "IosevkaFixed Nerd Font Extended 13"))
(add-to-list 'default-frame-alist `(fullscreen . maximized))
(set-language-environment "UTF-8")
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq native-comp-speed 2)
;; A second, case-insensitive pass over `auto-mode-alist' is time wasted.
;; No second pass of case-insensitive search over auto-mode-alist.
(setq auto-mode-case-fold nil)
;; Reduce *Message* noise at startup. An empty scratch buffer (or the
;; dashboard) is more than enough, and faster to display.
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)
(setq initial-buffer-choice nil
      inhibit-startup-buffer-menu t
      inhibit-x-resources t)
;; Disable bidirectional text scanning for a modest performance boost.
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
;; The initial buffer is created during startup even in non-interactive
;; sessions, and its major mode is fully initialized. Modes like `text-mode',
;; `org-mode', or even the default `lisp-interaction-mode' load extra packages
;; and run hooks, which can slow down startup.
;;
;; Using `fundamental-mode' for the initial buffer to avoid unnecessary
;; startup overhead.
(setq initial-major-mode 'fundamental-mode
      initial-scratch-message nil)
(setq package-enable-at-startup nil)  ; Let the init.el file handle this
(setq package-archives '(("melpa"        . "https://melpa.org/packages/")
                         ("gnu"          . "https://elpa.gnu.org/packages/")
                         ("nongnu"       . "https://elpa.nongnu.org/nongnu/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))
(setq package-archive-priorities '(("gnu"    . 99)
                                   ("nongnu" . 80)
                                   ("melpa"  . 70)
                                   ("melpa-stable" . 50)))

(setq ring-bell-function 'ignore)
(setq url-proxy-services '(("http"  .  "127.0.0.1:10808")
			   ("https" .  "127.0.0.1:10808")))
(setq recenter-redisplay nil)
(push '(menu-bar-lines . 0) default-frame-alist)
(setq menu-bar-mode nil)
(push '(tool-bar-lines . 0) default-frame-alist)
(setq tool-bar-mode nil)
(setq default-frame-scroll-bars 'right)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

