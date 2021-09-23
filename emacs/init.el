(set-face-attribute 'default nil :font "IBM Plex Mono" :height 110)

(defun edit-config ()
  "Open my config"
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c c") 'edit-config)

(setq echo-keystrokes 0.1) ; decrease delay between keypress and echo
(setq inhibit-startup-message t) ; start with a clean screen
(scroll-bar-mode 0) ; disable scrollbar
(tool-bar-mode 0) ; disable toolbar
(tooltip-mode 0) ; disable tooltips
(menu-bar-mode 0) ; disable menubar
(load-theme 'wombat) ; color scheme
(set-cursor-color "#aaaaaa") ; cursor color

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'smooth-scrolling)
(require 'evil)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-ui lsp-java dirtree doom-modeline counsel evil restclient geiser-mit use-package smooth-scrolling smooth-scroll)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(smooth-scrolling-mode t) ; scroll screen when cursor is nearits edge

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

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(require 'lsp-java)
(use-package lsp-ui)
(add-hook 'java-mode-hook #'lsp)
