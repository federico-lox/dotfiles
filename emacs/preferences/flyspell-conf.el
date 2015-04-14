;;;;
;; Flyspell
;;;;

;; Fix right click on mac
(when (eq system-type 'darwin)
  (eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined))))

;; Automatically enable for some modes
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'markdown-mode-hook #'flyspell-mode)
(add-hook 'gfm-mode-hook #'flyspell-mode)
