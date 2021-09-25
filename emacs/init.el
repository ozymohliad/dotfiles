;; Set up package repositories
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; Color scheme
(use-package gruvbox-theme
  :ensure t
  :init (load-theme 'gruvbox t))


;; User interface preferences
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 110)
(setq echo-keystrokes 0.1) ; decrease delay between keypress and echo
(setq inhibit-startup-message t) ; start with a clean screen
(setq mouse-highlight nil) ; disable the hideous borders aroun ui element on hover
(scroll-bar-mode 0) ; disable scrollbar
(tool-bar-mode 0) ; disable toolbar
(tooltip-mode 0) ; disable tooltips
(menu-bar-mode 0) ; disable menubar
(set-cursor-color "#aaaaaa") ; cursor color

;; Answer yes-no questions with M-p M-n
(mapcar (lambda (elt) (add-to-list 'yes-or-no-p-history elt)) '("no" "yes"))

;; Custom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


;; Set up ivy
(use-package ivy
  :diminish ivy-mode
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
	 ("C-d" . ivy-reverse-i-search-kill)))
(ivy-mode 1)


;; Enable smooth scrolling 
(use-package smooth-scrolling
  :ensure t
  :init (smooth-scrolling-mode 1))


;; Enable vim emulation
(use-package evil
  :ensure t
  :init (evil-mode t))

;; Completion
(use-package company
  :ensure t
  :config
  (progn (add-hook 'after-init-hook 'global-company-mode)))


;; Java LSP
(unless (package-installed-p 'lsp-java)
  (package-install 'lsp-java))
(unless (package-installed-p 'lsp-ui)
  (package-install 'lsp-ui))
(require 'lsp-java)
(require 'lsp-ui)
(add-hook 'java-mode-hook #'lsp)


;; Edit config shortcut
(defun edit-config ()
  "Open my config"
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c c") 'edit-config)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(package-selected-packages
   '(flycheck lsp-ui lsp-java dirtree counsel evil restclient geiser-mit use-package smooth-scroll)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
