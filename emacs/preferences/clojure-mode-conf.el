;;;;
;; Clojure-mode
;;;;

;; Extra sintax highlight (experimental, disable if it causes problems)
(require 'clojure-mode-extra-font-locking)

;; Ease navigation when using CamelCase (e.g. Java interop)
(add-hook 'clojure-mode-hook #'subword-mode)

;; Enable Rainbow Delimiters (requires rainbow-delimiters)
;(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'magic-mode-alist '(".* boot" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))
