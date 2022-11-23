(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

  ;; use-package to simplify the config file
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure 't)

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

(setq inhibit-startup-message t cursor-type 'bar)
(setq ring-bell-function 'ignore)
(setq visual-bell t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(setq use-dialog-box nil)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 100)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defun arzt/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mod
		  git-rebase-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))
(use-package evil
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-undo-system 'undo-tree)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :ensure t
  :after evil
  :init
  (evil-collection-init))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
(global-auto-revert-mode 1)

;; File Clutter
;;(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))
;;(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
;;(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
;;      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))
;;(setq user-emacs-directory (expand-file-name "~/.cache/emacs"))
;;
(use-package no-littering
  :ensure t
  :config
    (add-to-list 'recentf-exclude no-littering-var-directory)
    (add-to-list 'recentf-exclude no-littering-etc-directory)
    (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
    (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  )

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("C-s" . swiper-isearch)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x b" . ivy-switch-buffer)
	 
	 )
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel-projectile
  :init
  (counsel-projectile-mode))

;; ui
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(use-package rainbow-delimiters
  :ensure t
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package all-the-icons
  :ensure t)

(use-package modus-themes
  :ensure t
  :init
  (setq
   modus-themes-italic-constructs t
	modus-themes-bold-constructs t
	modus-themes-mixed-fonts nil
	modus-themes-subtle-line-numbers t
	modus-themes-intense-mouseovers t
	modus-themes-deuteranopia nil
	modus-themes-tabs-accented t
	modus-themes-variable-pitch-ui nil
	modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

	modus-themes-fringes nil; {nil,'subtle,'intense}

	;; Options for `modus-themes-lang-checkers' are either nil (the
	;; default), or a list of properties that may include any of those
	;; symbols: `straight-underline', `text-also', `background',
	;; `intense' OR `faint'.
	modus-themes-lang-checkers nil

	;; Options for `modus-themes-mode-line' are either nil, or a list
	;; that can combine any of `3d' OR `moody', `borderless',
	;; `accented', a natural number for extra padding (or a cons cell
	;; of padding and NATNUM), and a floating point for the height of
	;; the text relative to the base font size (or a cons cell of
	;; height and FLOAT)
	modus-themes-mode-line '(accented borderless (padding . 4) (height . 0.8))

	;; Same as above:
	;; modus-themes-mode-line '(accented borderless 4 0.9)

	;; Options for `modus-themes-markup' are either nil, or a list
	;; that can combine any of `bold', `italic', `background',
	;; `intense'.
	modus-themes-markup '(background italic)

	;; Options for `modus-themes-syntax' are either nil (the default),
	;; or a list of properties that may include any of those symbols:
	;; `faint', `yellow-comments', `green-strings', `alt-syntax'
	modus-themes-syntax '(yellow-comments green-strings alt-syntax)

	;; Options for `modus-themes-hl-line' are either nil (the default),
	;; or a list of properties that may include any of those symbols:
	;; `accented', `underline', `intense'
	modus-themes-hl-line '(underline accented)

	;; Options for `modus-themes-paren-match' are either nil (the
	;; default), or a list of properties that may include any of those
	;; symbols: `bold', `intense', `underline'
	modus-themes-paren-match '(bold intense underline)

	;; Options for `modus-themes-links' are either nil (the default),
	;; or a list of properties that may include any of those symbols:
	;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
	;; `bold', `italic', `background'
	modus-themes-links '(bold background)

	;; Options for `modus-themes-box-buttons' are either nil (the
	;; default), or a list that can combine any of `flat', `accented',
	;; `faint', `variable-pitch', `underline', `all-buttons', the
	;; symbol of any font weight as listed in `modus-themes-weights',
	;; and a floating point number (e.g. 0.9) for the height of the
	;; button's text.
	modus-themes-box-buttons '(variable-pitch flat faint 0.9)

	;; Options for `modus-themes-prompts' are either nil (the
	;; default), or a list of properties that may include any of those
	;; symbols: `background', `bold', `gray', `intense', `italic'
	;; modus-themes-prompts '(intense bold)
	modus-themes-prompts '(intense italic bold)

	;; The `modus-themes-completions' is an alist that reads three
	;; keys: `matches', `selection', `popup'.  Each accepts a nil
	;; value (or empty list) or a list of properties that can include
	;; any of the following (for WEIGHT read further below):
	;;
	;; `matches' - `background', `intense', `underline', `italic', WEIGHT
	;; `selection' - `accented', `intense', `underline', `italic', `text-also' WEIGHT
	;; `popup' - same as `selected'
	;; `t' - applies to any key not explicitly referenced (check docs)
	;;
	;; WEIGHT is a symbol such as `semibold', `light', or anything
	;; covered in `modus-themes-weights'.  Bold is used in the absence
	;; of an explicit WEIGHT.
	modus-themes-completions '((matches . (extrabold))
				    (selection . (semibold accented))
				    (popup . (accented intense)))

	modus-themes-mail-citations nil ; {nil,'intense,'faint,'monochrome}

	;; Options for `modus-themes-region' are either nil (the default),
	;; or a list of properties that may include any of those symbols:
	;; `no-extend', `bg-only', `accented'
	;; modus-themes-region '(bg-only no-extend)
	modus-themes-region '(bg-only no-extend)

	;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
	modus-themes-diffs 'desaturated

	modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

	modus-themes-org-agenda ; this is an alist: read the manual or its doc string
	'((header-block . (variable-pitch 1.3))
	    (header-date . (grayscale workaholic bold-today 1.1))
	    (event . (accented varied))
	    (scheduled . uniform)
	    (habit . traffic-light))

	modus-themes-headings ; this is an alist: read the manual or its doc string
	'((1 . (overline background variable-pitch 1.3))
	    (2 . (rainbow overline 1.1))
	    (t . (semibold))))
  :config
  ;; (setq modus-theme-mode-line '(accented borderless))
  (load-theme 'modus-vivendi t))

(use-package which-key
  :init
  (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package magit
  :ensure t)

(defun arzt/open-term ()
  (interactive)
  (split-window-below)
  (windmove-down)
  (vterm))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer arzt/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (arzt/leader-keys
   "SPC" '(counsel-M-x :which-key "M-x")
   "h" '(:ignore t :which-key "help")
	"v" '(describe-variable :which-key "describe var")
   "T" '(:ignore t :which-key "Toggles")
	"Tt" '(counsel-load-theme :which-key "choose-theme")

   "w" '(:ignroe t :which-key "window")
	"ws" '(split-window-below :which-key "split down")
	"wv" '(split-window-right :which-key "split right")
	"wj" '(windmove-down :which-key "go to window down")
	"wk" '(windmove-up :which-key "go to window up")
	"wh" '(windmove-left :which-key "go to window left")
	"wl" '(windmove-right :which-key "go to window right")

   "b" '(:ignroe t :which-key "buffer")
	"bb" '(counsel-buffer-or-recentf :which-key "open recent")
	"bp" '(previous-buffer :which-key "previous buffer")
	"bn" '(next-buffer :which-key "previous buffer")
	"bk" '(kill-buffer :which-key "kill buffer")

   "f" '(:ignore t :which-key "files")
	"ff" '(counsel-find-file :which-key "find")
   "g" '(:ignore t :which-key "git")
	"gg" '(magit-status :which-key "status")

   "p" '(:ignore t :which-key "projectile")
	"pp" '(counsel-projectile-switch-project :which-key "switch project")
	"pa" '(projectile-add-known-project :which-key "add project")
	"pd" '(projectile-add-known-project :which-key "add project")
	"pf" '(counsel-projectile :which-key "find file")
   "l" '(:ignore t :which-key "lsp")
	"lf" '(apheleia-format-buffer :which-key "format buffer")
	"ld" '(:ignore t :which-key "lsp")
	    "ldd" '(lsp-ui-doc-glance :which-key "focus doc")
	    "ldD" '(lsp-ui-doc-focus-frame :which-key "focus doc")
   "o" '(:ignore t :which-key "open")
	"of" '(treemacs t :which-key "open file drawer")
	"oT" '(vterm t :which-key "open term here")
	"ot" '(arzt/open-term :which-key "open term below")
   "/" '(evilnc-comment-or-uncomment-lines :which-key "comment line(s)")
  ))

(use-package hydra)

(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

;; project crap
(use-package projectile
  :ensure t
  :defer t
  :init
  (setq projectile-indexing-method 'hybrid
	projectile-sort-order 'recentf
	projectile-enable-caching t)
  (projectile-mode t))

;; lang crap
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map ("M-RET" . lsp-execute-code-action))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)

  (lsp-enable-which-key-integration t))

(use-package lsp-ui
 ; :hook (lsp-mode . lsp-ui-mode)
 ; :bind (:map lsp-ui-mode-map ("C-q" . arzt/lsp-focus))
 ; :config
 ; (setq lsp-enable-symbol-highlighting t)
 ; (setq lsp-ui-doc-enable t)
 ; (setq lsp-lens-enable t)
  )

;; debug
(use-package dap-mode
  :hook (lsp-mode . dap-mode)
)



(use-package company
  :after lsp-mode
  ;;     trigger    then do
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
	("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))


(use-package typescript-mode
  :after tree-sitter
  :mode ("\\.ts\\'"
	"\\.tsx\\'"
	 "\\.js\\'")
  
  :hook (typescript-mode . lsp-deferred)
  :config
  (define-derived-mode typescriptreact-mode typescript-mode "TypeScript TSX")
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  ;; by default, typescript-mode is mapped to the treesitter typescript parser
  ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx))
  (require 'dap-node)
  (dap-node-setup)
  (require 'dap-chrome)
  (dap-chrome-setup))

(use-package tsi
  :after tree-sitter
  :quelpa (tsi :fetcher github :repo "orzechowskid/tsi.el")
  ;; define autoload definitions which when actually invoked will cause package to be loaded
  :commands (tsi-typescript-mode tsi-json-mode tsi-css-mode)
  :init
  (add-hook 'typescript-mode-hook (lambda () (tsi-typescript-mode 1)))
  (add-hook 'json-mode-hook (lambda () (tsi-json-mode 1)))
  (add-hook 'css-mode-hook (lambda () (tsi-css-mode 1)))
  (add-hook 'scss-mode-hook (lambda () (tsi-scss-mode 1))))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(use-package tree-sitter
  :ensure t
  :hook (tree-sitter-mode . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t)

(use-package treemacs-evil)
(use-package treemacs-all-the-icons
  :ensure t)

(use-package treemacs
  :ensure t
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package lsp-treemacs
  :after lsp)

(use-package vterm
  :ensure t)
  
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 5))
	dashboard-startup-banner (expand-file-name "img/logo.gif" user-emacs-directory)
	dashboard-center-content t
	dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name))
