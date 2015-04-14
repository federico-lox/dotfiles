;;;;
;; Company mode
;;;;

;; Popup completion list after the 2nd character
(setq company-minimum-prefix-length 2)

;; Enable globally
(add-hook 'after-init-hook 'global-company-mode)

;; Bind tab key to trigger completion or cycling candidates
(global-set-key (kbd "C-.") (lambda () (interactive) (company-complete-common-or-cycle 1)))
(global-set-key (kbd "C-,") (lambda () (interactive) (company-complete-common-or-cycle -1)))
