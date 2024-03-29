;;;;
;; Packages
;;;;

(load-file (expand-file-name
            (cond ((eq system-type 'windows-nt) "windows.el")
                  ((eq system-type 'gnu/linux) "linux.el"))
            user-emacs-directory))

(require 'restclient)
(require 'misc)
(require 'org)
(setq inhibit-startup-screen t)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key "\M-Z" 'zap-up-to-char)
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev 
        try-expand-dabbrev-all-buffers 
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially 
        try-complete-file-name 
        try-expand-all-abbrevs 
        try-expand-list 
        try-expand-line 
        try-complete-lisp-symbol-partially 
        try-complete-lisp-symbol))

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(coffee-tab-width 2)
 '(org-agenda-files (list org-directory))
 '(package-selected-packages
   (quote
    (evil cider restclient tagedit smex rainbow-delimiters projectile paredit magit ido-completing-read+ exec-path-from-shell))))

;; Type y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Kill the current buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Define package repositories
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Define he following variables to remove the compile-log warnings
;; when defining ido-ubiquitous
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(defvar predicate nil)
(defvar inherit-input-method nil)

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

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

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

(set-face-attribute 'default nil :height 120)

(define-key minibuffer-local-map "\M-s" nil)

(setq find-program "\"C:\\Program Files\\Git\\usr\\bin\\find.exe\"")

(global-set-key (kbd "M-z") 'zap-up-to-char)

(defun logeu ()
  (interactive)
  (let ((name (format-time-string "%Y-%m-%d")))
    (find-file (expand-file-name (concat "/Users/cosmin/notes/eu/log/" name ".txt")))))

(defun logito ()
  (interactive)
  (let ((name (format-time-string "%Y-%U")))
    (find-file (expand-file-name (concat "/Users/cosmin/notes/org/ito33-log/ito33-log-" name ".org")))))

(require 'goto-last-change)

(global-set-key "\C-x\C-\\" 'goto-last-change)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
