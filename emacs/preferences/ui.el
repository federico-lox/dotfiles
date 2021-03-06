;;;;
;; User Interface
;; This is loaded before any additional package which is not built-in.
;;;;

;; Disable splashcreen and welcome message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; Configure scratch buffer
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;; Set default frame size
(let ((frame-width 125)
      (frame-height 50))
  (when window-system
    (set-frame-size (selected-frame) frame-width frame-height) ;set size immediately while loading
    (setq default-frame-alist '((width . frame-width) ;set size for any frame created later on
                                (height . frame-height)))))

;; Disable UI elements
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Show line numbers
(global-linum-mode t)

;; Show line nd column number in modeline
(column-number-mode t)

;; Highlights parenteses
(setq-default show-paren-delay 0)
(show-paren-mode t)
(setq-default show-paren-style 'mixed)

;; No bell
(setq ring-bell-function 'ignore)

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t
      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t
      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t
      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t
      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)

;; Change yes/no to y/n in confirmation prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; Font/line settings
(cond
 ((member "Menlo" (font-family-list))
  (set-face-attribute 'default nil :font "Menlo")
  (set-face-attribute 'default nil :height 140))
 ((member "Consolas" (font-family-list))
  (set-face-attribute 'default nil :font "Consolas")
  (set-face-attribute 'default nil :height 110)))

(setq-default line-spacing 8)

;; No cursor in non-selected windows
(setq cursor-in-non-selected-windows nil)

;; Don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))
