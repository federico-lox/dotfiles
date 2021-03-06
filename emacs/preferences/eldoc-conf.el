;;;;
;; Eldoc
;;;;

;; eldoc-mode shows documentation in the minibuffer when writing code
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(when (package-installed-p 'cider)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode))

(when (package-installed-p 'tide)
  (add-hook 'tide-mode-hook 'turn-on-eldoc-mode))
