(require 'recentf)

;; disable cleanup to avoid hanging for tramp-mode entries
(setq recentf-auto-cleanup 'never)

(recentf-mode 1)
(setq recentf-max-saved-items 50)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'ido-recentf-open)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
