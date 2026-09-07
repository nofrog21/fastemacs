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
