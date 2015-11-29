;;; package --- Summary
;;; Commentary:
;;; Code:

;;;;
;; Garbage collection
;;;;

;; On today's machines setting this higher will avoid the stop-the-world GC to kick in too often
(setq gc-cons-threshold 20000000) ;20 MB

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
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; interactively manage the kill ring
    browse-kill-ring

    ;; integration with a Clojure REPL
    cider

    ;; key bindings and code colorization for Clojure
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; Company mode autocompletion
    company

    ;; Filesystem browser improvemens
    dired+

    ;; Linting and syntax check
    flycheck

    ;; Better fuzzy algorythm for ido
    flx-ido

    ;; allow ido usage in as many contexts as possible
    ido-ubiquitous

    ;; allow showing ido suggestion in a vertical list
    ido-vertical-mode

    ;; Better JavaScript support
    js2-mode

    ;; JSON support
    json-mode

    ;; git integration
    magit

    ;; Markdown support
    markdown-mode

    ;; allow multiple cursors
    multiple-cursors

    ;; better terminal emulation
    multi-term

    ;; makes handling lisp expressions much, much easier
    ;paredit

    ;; make the contents of the scratch buffer persistent across sessions
    persistent-scratch

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    ;;rainbow-delimiters

    ;; Preview hex color codes inline
    rainbow-mode

    ;; makes handling lisp expressions much, much easier
    smartparens

    ;; Soft morning theme
    soft-morning-theme

    ;; Enhances M-x to allow easier execution of commands
    smex

    ;; edit html tags like sexps
    ;tagedit

    ;; TypeScript IDE
    tide

    ;; better management of undo tree
    undo-tree

    ;; HTML and web templates editor
    web-mode
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
;; some user interface elements, load ASAP
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Packages configuration
(load "browse-kill-ring-conf.el")
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
(load "multi-term-conf.el")
;(load "paredit-conf.el")
(load "persistent-scratch-conf.el")
(load "projectile-conf.el")
(load "rainbow-mode-conf.el")
(load "recentf-conf.el")
(load "smartparens-conf.el")
(load "smex-conf.el")
(load "theme-conf.el")
(load "tide-conf.el")
(load "undo-tree-conf.el")
(load "whitespace-conf.el")
(load "web-mode-conf.el")
