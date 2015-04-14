;;;;
;; Interactively DO things
;;;;

(ido-mode t)

;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
(setq ido-enable-flex-matching t)

;; Turn this behavior off because it's annoying
(setq ido-use-filename-at-point nil)

;; Use ido wherever possible
(ido-everywhere t)

;; Really use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode t)

;; Show vertical list
(require 'ido-vertical-mode)
(ido-vertical-mode t)