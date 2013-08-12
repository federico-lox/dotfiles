;;;; Initialization
;; setup MELPA repo
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t))

(add-to-list 'load-path "~/.emacs.d/packages")

;;;; UI settings
;; set color scheme
(load-theme 'deeper-blue t)

;; show line and column numbers in status line
(column-number-mode 1)

;; font/line settings
(if (and window-system (eq system-type 'windows-nt))
    (set-face-attribute 'default nil :font "Consolas"))
(set-face-attribute 'default nil :height 120);12pt
(setq-default line-spacing 10)
(global-linum-mode t);show line numbers

;;matching delimiters
(show-paren-mode 1);highlight matching pairs

;; cursor
(setq-default cursor-type 'bar);show as bar
(blink-cursor-mode 0);don't blink
;(when window-system
;  (global-hl-line-mode));hilight line where cursor is
(setq cursor-in-non-selected-windows nil);no cursor in non-selected windows

;; System bell
(setq visible-bell 1);use visual bell rather than alarm sound

;; Splashcreen
(setq inhibit-startup-message t);disable splashscreen buffer
(setq inhibit-startup-echo-area-message t)

;; Disable UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; full screen
;; see http://www.emacswiki.org/emacs/FullScreen
;; this should be the last command to run after all the UI options are set
(when window-system
  (if (eq system-type 'windows-nt)
    (w32-send-sys-command #xf030)
  )
)

;; Show whitespaces
(require 'whitespace)
(setq whitespace-line-column 80
      whitespace-style '(face trailing lines-tail))
(set-face-attribute 'whitespace-line nil
		    :foreground "yellow")
(set-face-attribute 'whitespace-trailing nil
		    :background "red")
(global-whitespace-mode 1)

;;;; Input
;; Modern settings form managing selection and clipboard operations
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Keep the region after yanking

;; change yes/no to y/n in confirmation prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; nuke trailing whitespaces when writing to a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Matching pairs
;(electric-pair-mode 1)
(require 'autopair)
(autopair-global-mode)

;;;Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;;Indentation
(define-key global-map (kbd "RET") 'newline-and-indent);auto-indent new lines

(defun tabs-only ()
  (setq indent-tabs-mode t)
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (setq c-basic-indent my-tab-width)))
(add-hook 'php-mode-hook 'tabs-only)
(add-hook 'js-mode-hook 'tabs-only)
(add-hook 'html-mode-hook 'tabs-only)

;;;; Auto completion
;;; Ido mode
(require 'flx-ido)
(ido-mode 1)
(flx-ido-mode 1)
(setq ido-use-faces nil);Disable ido faces to see flx highlights.

;; Use ido wherever possible
(ido-everywhere 1)
(require 'ido-ubiquitous)
(ido-ubiquitous)
(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;;; Auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)
(global-auto-complete-mode t)

;;;Yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets")) ;"~/.emacs.d/elpa/yasnippet-20130722.1832/snippets"))
(yas-global-mode 1)

;;;Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;; Files and folders
;; Directory to use as the default
(setq default-directory "~/")

;; Disable backup and autosave
;; remote machines might have limited resources/quotas
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Recent file list
(require 'recentf)
(require 'recentf-ido)
(recentf-mode 1)
(setq recentf-max-menu-items 50)

;;;Projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-use-native-indexing nil)

;;;; External tools
;;; Shells
;;msys shell as default on windows
(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "bash.exe")
  (setq shell-file-name "bash")
  (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
  (setenv "SHELL" shell-file-name)
  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m))

;;;; Custom Key bindings (keep as the last section)
;;; Buffer management
(global-set-key (kbd "<C-tab>") 'switch-to-next-buffer)
(global-set-key (kbd "<C-S-tab>") 'switch-to-prev-buffer)
(global-set-key (kbd "C-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-o") 'find-file)

;;; Window management
(global-set-key (kbd "M-w") 'other-window)
(global-set-key (kbd "M-q") 'delete-window)
(global-set-key (kbd "M-s v") (lambda ()
				"Create a new vertical split and activate it"
				(interactive)
				(split-window-horizontally)
				(other-window 1)))
(global-set-key (kbd "M-s h") (lambda ()
				"Create a new horizontal split and activate it"
				(interactive)
				(split-window-vertically)
				(other-window 1)))
(global-set-key (kbd "M-RET") 'maximize-window)
(global-set-key (kbd "M-=") 'balance-windows)
(global-set-key (kbd "M-[") 'shrink-window)
(global-set-key (kbd "M-]") 'enlarge-window)
(global-set-key (kbd "M-{") 'shrink-window-horizontally)
(global-set-key (kbd "M-}") 'enlarge-window-horizontally)

;;; Regions
(global-set-key (kbd "C-a") 'mark-whole-buffer)

;;; Text manipulation
(global-set-key (kbd "M-d") 'kill-line)

;; Recent files menu
(global-set-key (kbd "M-o") 'recentf-ido-find-file)

;; Project navigation
(global-set-key (kbd "M-p f") 'projectile-find-file)
(global-set-key (kbd "M-p d") 'projectile-find-dir)
(global-set-key (kbd "M-p p") 'projectile-switch-project)
(global-set-key (kbd "M-p b") 'projectile-dired)
