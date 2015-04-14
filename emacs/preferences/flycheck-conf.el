;;;;
;; Flycheck
;;;;

;; Enable in all the modes
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Check on save
(setq flycheck-check-syntax-automatically '(mode-enabled save))
