;; -*- lexical-binding: t; -*-
(defun up-directory (arg)
  "Move up a directory (delete backwards to /)."
  (interactive "p")
  (if (string-match-p "/." (minibuffer-contents))
      (delete-region (point)
		             (progn
		               (forward-char -1)
		               (unwind-protect
			               (search-forward "/" nil nil (- arg))
			             (backward-char -1))
		               (point)))
    (delete-minibuffer-contents)
    )
  )

(defun generate-test-report (start end filename)
  "Generate test file with given filename and region to form a header"
  (interactive
   (list (region-beginning) (region-end) (read-file-name "Find file: " nil default-directory)))
  (write-region (concat "# " (buffer-substring start end) "\n\n## Описание\n\n## Детали\n\n__Статус: Не проверялся__") nil filename)
  )

(defun display-buffer-compilation-mode-p (buffer-name action)
  "Determine whether BUFFER-NAME is a compilation buffer."
  (with-current-buffer buffer-name
    (or
     (eq 'compilation-mode (buffer-local-value 'major-mode (current-buffer)))
     (string-match (rx "*[Cc]ompilation*")
                   buffer-name))))

(defun cd-compile ()
  "Change default-directory and run compile-command"
  (interactive)
  (with-temp-buffer
    (call-interactively 'cd)
    (call-interactively 'compile))
  )

(defun evil-ex-start-search-with-region-string ()
    (let ((selection (with-current-buffer (other-buffer (current-buffer) 1)
                       (when (evil-visual-state-p)
                         (let ((selection (buffer-substring-no-properties (region-beginning)
                                                                          (1+ (region-end)))))
                           (evil-normal-state)
                           selection)))))
      (when selection
        (evil-ex-remove-default)
        (insert selection)
        (evil-ex-search-activate-highlight (list selection
                                                 evil-ex-search-count
                                                 evil-ex-search-direction)))))
(defun evil-ex-search-word-backward-advice (old-func count &optional symbol)
    (if (evil-visual-state-p)
        (let ((region (buffer-substring-no-properties
                       (region-beginning) (1+ (region-end)))))
          (setq evil-ex-search-pattern region)
          (deactivate-mark)
          (evil-ex-search-full-pattern region count 'backward))
      (apply old-func count symbol)))

(defun evil-ex-search-word-forward-advice (old-func count &optional symbol)
    (if (evil-visual-state-p)
        (let ((region (buffer-substring-no-properties
                       (region-beginning) (1+ (region-end)))))
          (setq evil-ex-search-pattern region)
          (deactivate-mark)
          (evil-ex-search-full-pattern region count 'forward))
      (apply old-func count symbol)))
