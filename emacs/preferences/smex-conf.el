;;;;
;; Smex
;;;;

(require 'smex)
(setq smex-save-file (concat user-emacs-directory ".smex-items"))

(smex-initialize)

;; Show all commands
(global-set-key (kbd "M-x") 'smex)

;; Show only commands valid for the current major mode
(global-set-key (kbd "M-X") 'smex-major-mode-commands)