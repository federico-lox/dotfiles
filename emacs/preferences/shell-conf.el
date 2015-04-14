;;;;
;; Shell
;;;;

;;  Set msys shell as default on windows
(when (eq system-type 'windows-nt)
  (cond
   ((executable-find "bash")
    (setq explicit-shell-file-name "bash.exe")
    (setq shell-file-name "bash")
    (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
    (setenv "SHELL" shell-file-name)
    (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m))))
