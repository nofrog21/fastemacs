;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-ts-mode-indent-style 'bsd)
 '(eaf-webengine-font-family "IosevkaFixed Nerd Font Extended")
 '(font-lock-maximum-decoration 2)
 '(package-selected-packages
   '(cape corfu go-mode lua-mode magit marginalia markdown-mode move-text
          multiple-cursors rainbow-mode rust-mode yaml-mode))
 '(project-file-history-behavior 'relativize)
 '(uxntal-uxnasm-path "uxn2 /home/ivan/opt/uxn2/etc/utils/drifblim.rom")
 '(uxntal-uxnemu-path "uxn2")
 '(whitespace-style
   '(face trailing tabs spaces space-before-tab space-mark tab-mark))
 '(with-editor-sleeping-editor
   "bash -c 'printf \"\\nWITH-EDITOR: $$ OPEN $0\\037$1\\037 IN $(pwd)\\n\"; sleep 604800 & sleep=$!; trap \"kill $sleep; exit 0\" USR1; trap \"kill $sleep; exit 1\" USR2; wait $sleep'"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-blue ((t (:background "DeepSkyBlue3" :foreground "DeepSkyBlue3"))))
 '(flymake-error ((t (:underline (:color foreground-color :style wave :position nil)))))
 '(flymake-note ((t (:underline (:color foreground-color :style wave :position nil)))))
 '(flymake-warning ((t (:underline (:color foreground-color :style wave :position nil)))))
 '(marginalia-file-priv-write ((t (:inherit font-lock-constant-face))))
 '(marginalia-key ((t (:inherit font-lock-constant-face))))
 '(marginalia-mode ((t (:inherit ##))))
 '(org-date ((t (:foreground "white" :underline t)))))
