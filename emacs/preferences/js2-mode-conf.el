;;;;
;; JS2 Mode
;;;;

;; Automatically enable for some file extensions
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Syntax highlight common ECMA properties and functions
(setq js2-highlight-level 3)
