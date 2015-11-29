;;;;
;; Smartparens
;;;;

;; Load default config
(require 'smartparens-config)

(smartparens-global-mode t)

;; Highlight matching pairs
;(show-smartparens-global-mode t)

;; Enable strict mode for Lisp dialects
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-strict-mode)
(add-hook 'ielm-mode-hook #'smartparens-strict-mode)
(add-hook 'lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-strict-mode)
(add-hook 'scheme-mode-hook #'smartparens-strict-mode)
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)

(setq-default sp-hybrid-kill-entire-symbol nil)

;; Disable pair overlay
(setq sp-highlight-pair-overlay nil)

;; Key bindings
;(define-key sp-keymap (kbd "<delete>") 'sp-delete-char)
(define-key sp-keymap (kbd "C-<left>") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-S-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-S-<right>") 'sp-backward-barf-sexp)
(define-key sp-keymap (kbd "M-s") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "M-S-s") 'sp-raise-sexp)
(define-key sp-keymap (kbd "M-i") 'sp-split-sexp)
(define-key sp-keymap (kbd "M-S-i") 'sp-join-sexp)
(define-key sp-keymap (kbd "M-t") 'sp-transpose-sexp)
(define-key sp-keymap (kbd "M-S-<left>") 'sp-backward-sexp)
(define-key sp-keymap (kbd "M-S-<right>") 'sp-forward-sexp)

;;;;;;;;;;;;;;;;;;
;; pair management

(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)

;;; markdown-mode
(sp-with-modes '(markdown-mode gfm-mode rst-mode)
  (sp-local-pair "*" "*" :bind "C-*")
  (sp-local-tag "2" "**" "**")
  (sp-local-tag "s" "```scheme" "```")
  (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

;;; tex-mode latex-mode
(sp-with-modes '(tex-mode plain-tex-mode latex-mode)
  (sp-local-tag "i" "\"<" "\">"))

;;; html-mode
(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))

;;; lisp modes
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil :bind "C-("))
