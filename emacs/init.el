;;;;
;; Packages
;;;;

(require 'package)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Define package repositories
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives
;             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; integration with a Clojure REPL
    cider

    ;; key bindings and code colorization for Clojure
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; Solarized theme
    color-theme-solarized

    ;; Company mode autocompletion
    company

    ;; Filesystem browser improvemens
    dired+

    ;; Linting and syntax check
    flycheck

    ;; allow ido usage in as many contexts as possible
    ido-ubiquitous

    ;; allow showing ido suggestion in a vertical list
    ido-vertical-mode

    ;; Better JavaScript support
    js2-mode

    ;; JSON support
    json-mode

    ;; Markdown support
    markdown-mode

    ;; allow multiple cursors
    multiple-cursors

    ;; makes handling lisp expressions much, much easier
    paredit

    ;; make the contents of the scratch buffer persistent across sessions
    persistent-scratch

    ;; makes handling lisp expressions much, much easier
    ;smartparens

    ;; Sublime text themes
    ;sublime-themes

    ;; Enhances M-x to allow easier execution of commands
    smex

    ;; project navigation
    ;projectile

    ;; colorful parenthesis matching
    ;rainbow-delimiters

    ;; edit html tags like sexps
    ;tagedit
    ;; git integration
    ;magit
))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
  (add-to-list 'my-packages 'exec-path-from-shell))

;; install the packages if they're not installed
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
(add-to-list 'load-path "~/.emacs.d/vendor")

;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/preferences")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Shell integration
(load "shell-conf.el")

;; Packages configuration
(load "clojure-mode-conf.el")
(load "company-conf.el")
(load "dired-conf.el")
(load "eldoc-conf.el")
(load "flycheck-conf.el")
(load "flyspell-conf.el")
(load "ido-conf.el")
(load "js2-mode-conf.el")
(load "json-mode-conf.el")
(load "markdown-mode-conf.el")
(load "multiple-cursors-conf.el")
(load "paredit-conf.el")
(load "persistent-scratch-conf.el")
;(load "smartparens-conf.el")
(load "smex-conf.el")
(load "whitespace-conf.el")

;; Custom section
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(frame-background-mode (quote dark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
