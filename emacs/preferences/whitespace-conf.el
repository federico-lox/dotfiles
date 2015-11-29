;;;;
;; Whitespace display
;;;;

;; Enable for programming language modes only
(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Show only tabs and trailing spaces
(setq-default whitespace-style '(face tabs tab-mark lines-tail trailing))
(setq-default whitespace-line-column 120)
