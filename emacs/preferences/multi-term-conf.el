;;;;
;; Multi term
;;;;

;; Use bash if available, otherwise ask
(when (executable-find "bash")
  (setq multi-term-program "bash")
  (when (eq system-type 'windows-nt)
    (setq explicit-shell-file-name "bash.exe")
    (setq shell-file-name "bash")
    (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
    (setenv "SHELL" shell-file-name)
    (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))

;; terminal mode exceptions
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)
            (setq show-trailing-whitespace nil)
            (electric-pair-mode 1)
            (electric-indent-mode -1)
            (show-paren-mode -1)
            (linum-mode -1)))
