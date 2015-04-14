;;;;
;; multiple-cursors
;;;;

;; add cursor on left click
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

;;add cursor at same column on prev/next line
(global-set-key (kbd "M-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-<down>") 'mc/mark-next-like-this)

;; alternative to RET for newline when mutliple cursors mode is active
(global-set-key (kbd "M-<RET>") 'newline)
