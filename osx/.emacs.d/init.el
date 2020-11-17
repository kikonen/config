;;; The Package Manager
;; this is most important addition to emacs24
;; M-x list-packages to view available packages
;; i to mark to install ;; d to mark to delete
;; x to execute those actions
(require 'package)

(setq package-archives
'(("gnu" . "http://elpa.gnu.org/packages/")
("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; HACK KI "Symbol's function definition is void: apropos-macrop"
;; http://stackoverflow.com/questions/20135194/emacs-css-mode-not-loading
(defalias 'apropos-macrop 'macrop)

;;; Making things pretty
(setq inhibit-splash-screen t) ; turn off splash screen
(show-paren-mode 1)

;; show char count
(add-to-list 'global-mode-string '(" %i"))

;; stop pesky ~ files from littering
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; change font globally to smaller one
(set-face-attribute 'default nil :height 100)

(when (display-graphic-p)
  (if (string-equal system-type "darwin")
      (set-fontset-font "fontset-default"
                        'unicode
                        '("Monaco" . "iso10646-1")))
    )


;;
;; http://www.emacswiki.org/emacs/FindingNonAsciiCharacters
;;
(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))


;; https://stackoverflow.com/questions/6918134/how-do-i-indent-n-spaces-in-emacs
(defun insert-tabs (n)
  "Inserts N number of tabs"
  (interactive "nNumber of tabs: ")
  (dotimes (i n)
    (indent-for-tab-command)))
(global-set-key [?\C-x \C-tab] 'insert-tabs)


;; To change the font
;;(set-frame-font "Consolas 10")

;; To load a theme
;; (load-theme 'theme-name)

;; disable pesky menus and scroll bars (uncomment to unclutter)
;; (menu-bar-mode -1)
;;(tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; prevent the whole window from flashing on bell
(when (equal system-type 'darwin)
(setq ring-bell-function #'ignore
visible-bell nil))

;; Answer with y and n instead of yes and no
 (defalias 'yes-or-no-p 'y-or-n-p)

;; turn off tabs, use spaces instead
(setq-default indent-tabs-mode nil)
;; shows column number next to line number
(column-number-mode t)
;; show line numbers
(global-linum-mode t)

;; normal "paste override selection" logic
(delete-selection-mode t)

;; delete trailing whitespace automatically
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Loading Code
;; add common directories for extensions to the load-path
;; so they can be require'd
(mapc (apply-partially #'add-to-list 'load-path)
'("~/.emacs.d/lisp"
"~/.emacs.d/site-lisp"
;;"~/.emacs.d/site-lisp/ecb"
"~/.emacs.d/themes"))

;; global revert - revbufs
(require 'revbufs)

;; ag
(setq ag-highlight-search t)
(setq ag-reuse-buffers t)

;; remote file sync
(require 'tramp)
(setq tramp-default-method "ssh")

;;
;; Indicate column overflow
;;
(require 'column-marker)
(add-hook 'text-mode-hook (lambda () (interactive) (column-marker-1 120)))
(add-hook 'ruby-mode-hook (lambda () (interactive) (column-marker-1 120)))
(add-hook 'js2-mode-hook (lambda () (interactive) (column-marker-1 120)))
(add-hook 'haml-mode-hook (lambda () (interactive) (column-marker-1 120)))

;;; Language Modes
;; Set ruby mode for some extra extensions that aren't on by default in Emacs 24:
(add-to-list 'auto-mode-alist (cons "\.rake$" 'ruby-mode))
(add-to-list 'auto-mode-alist (cons "Gemfile$" 'ruby-mode))
(add-to-list 'auto-mode-alist (cons "Rakefile$" 'ruby-mode))
(add-to-list 'auto-mode-alist (cons ".yml$" 'yaml-mode))
;;(add-to-list 'auto-mode-alist (cons ".*js.erb$" 'js2-mode))
;;(add-to-list 'auto-mode-alist (cons ".*html.erb$" 'javascript-mode))

;;
;; Enhanced Ruby Mode
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/enhanced-ruby-mode") ; must be added after any path containing old ruby-mode
;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; optional

;;(setq enh-ruby-program "(path-to-ruby1.9)/bin/ruby") ; so that still works if ruby points to ruby1.8
;;
;;
(setq ruby-deep-indent-paren nil)

;; ruby block highlight
;; @see http://www.emacswiki.org/emacs/download/hrb-mode.el
(require 'hrb-mode)
(hrb-mode t)
(setq hrb-delay 0)
(setq hrb-highlight-mode 'mixed)

;; sql indent
(eval-after-load "sql"
  '(load-library "sql-indent"))

;;
;; Helm
;;
;;(require 'helm-config)

;;
;; START MuMaMo
;;

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (equal emacs-major-version 24)
           (equal emacs-minor-version 3))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;:(load "nxhtml/autostart.el")

 ;; MuMaMo-Mode for rhtml files
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/nxhtml/util")
;;(require 'mumamo-fun)
;;(setq mumamo-background-colors nil)
;;(setq mumamo-chunk-coloring 'submode-colored)

;;(add-to-list 'auto-mode-alist '("\\.html\\'" . eruby-html-mumamo))
;;(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;;(add-to-list 'auto-mode-alist '("\\.html\\'" . eruby-html-mumamo))
;;(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))
;;(add-to-list 'auto-mode-alist '("\\.js\\.erb\\'" . eruby-javascript-mumamo-mode))

;;
;; web-mode
;;
(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))

;;
;; slim-mode
;;
(require 'slim-mode)
(add-to-list 'auto-mode-alist '("\\.html\\.slim\\'" . slim-mode))

;;
;; js2-mode
;;
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\.erb\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;;
;; js-lint
;; @see http://www.emacswiki.org/emacs/Flycheck
;; @see http://truongtx.me/2014/02/21/emacs-setup-jshint-for-on-the-fly-petential-error-checking/
;; @see http://www.jshint.com/docs/options/
;(require 'flycheck)
;(add-hook 'js2-mode-hook
;          (lambda () (flycheck-mode t)))

(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2015-06-11"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))

(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)

;;
;; scss-mode
;;
;; http://stackoverflow.com/questions/8888989/emacs-css-mode-syntax-table-missing
(load "css-mode")
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq css-indent-offset 2)
(setq scss-output-directory "/tmp/.css-cache")
(setq scss-sass-options '("--cache-location" "/tmp/.sass-cache"))

;; https://github.com/purcell/flymake-sass
;; => not working
;;(require 'flymake-sass)
;;(add-hook 'sass-mode-hook 'flymake-sass-load)

;;https://github.com/brigade/scss-lint
;;(add-hook 'scss-mode-hook 'flycheck-mode)

;;
;; haml-mode
;;
(autoload 'haml-mode "haml-mode")
(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))

;;
;; Ruby code browser
;;
;;(require 'ecb-autoloads)

;;
;; Keyboard macros
;;
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)

(fset 'previous-window-ki
      "\C-[-1\C-xo")
(global-set-key "\C-xp" 'previous-window-ki)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(global-set-key '[\S-f12] 'revert-buffer)
(global-set-key '[f12] 'revert-buffer)
(global-set-key '[\C-f12] 'revbufs)

;; Goto-line short-cut key
(global-set-key '[f11] 'goto-line)

;; F3 - Insert [current_file] into minibuffer
(define-key minibuffer-local-map [f3]
  (lambda () (interactive)
     (insert (buffer-name (window-buffer (minibuffer-selected-window))))))

;; toggle comment on/off
(global-set-key (quote [C-c !]) (quote comment-or-uncomment-region))

;; scroll line by line
(global-set-key (quote [M-down]) (quote scroll-up-line))
(global-set-key (quote [M-up]) (quote scroll-down-line))

;;; Customizations
;; Don't edit this section by hand, instead call M-x customize or
;; customize-group and use the menus.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(delete-selection-mode 1)
 '(ecb-options-version "2.40")
 '(electric-indent-mode nil)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(mark-even-if-inactive t)
 '(org-export-with-priority t)
 '(package-selected-packages
   '(ag ## gradle-mode vagrant web-mode php-mode yaml-mode slim-mode scss-mode marmalade kurecolor js2-mode hexrgb haml-mode flymake-sass flymake-haml flycheck-cask edit-color-stamp column-marker))
 '(ruby-align-to-stmt-keywords '(def if unless while begin for case))
 '(ruby-deep-indent-paren nil)
 '(scroll-bar-mode 'right)
 '(tool-bar-mode nil)
 '(transient-mark-mode 1)
 '(uniquify-buffer-name-style 'post-forward nil (uniquify))
 '(visible-bell f)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
