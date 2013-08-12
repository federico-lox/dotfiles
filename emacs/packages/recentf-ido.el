;;; Code:
(require 'ido)
(require 'recentf)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (let ((file (ido-completing-read "Open recent file: "
		  (mapcar (lambda (path)
		    (replace-regexp-in-string home "~" path))
		      recentf-list))))
      (when file
	(find-file file)))))

(provide 'recentf-ido)
;;; recentf-ido.el ends here
