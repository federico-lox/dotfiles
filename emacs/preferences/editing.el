;;;;
;; Editing
;;;;

;; Directory to use as the default
(setq default-directory "~/")

;; Put all backups in ~/.emacs.d/backups
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
											   "backups"))))

;; Disable backup and autosave
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Indentation
;; always use spaces
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-stop-list (number-sequence 4 200 4))

;; Auto-indent on delimiters
(electric-indent-mode +1)

;; Close delimiter pairs automatically
(electric-pair-mode 1)

;; Wrap lines on \s+
(setq-default word-wrap t)

;; Scroll one line at a time with the keyboard and show the next/previous
;; X lines when reaching top/bottom of the frame
(setq scroll-step 1)
(setq scroll-margin 2)

;; Automatically reload buffers if file on disk has changed
(global-auto-revert-mode 1)

;; nuke trailing whitespaces when writing to a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Spell check
;; find aspell and hunspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US"))))

;; Use gnu find
;(setq find-program "gnu-find.exe")
