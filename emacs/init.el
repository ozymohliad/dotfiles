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
(setq themes '(gruvbox-light-hard gruvbox-dark-hard))
(setq theme-index 0)
(use-package gruvbox-theme
  :ensure t
  :init (load-theme (nth 0 themes) t))


;; Custom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


;; User interface preferences
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 100)
(set-face-attribute 'mode-line nil :font "IBM Plex Mono" :height 100)
(setq doom-modeline-height 24)
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


;; Undo package
(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode t))


;; Enable vim emulation
(use-package evil
  :ensure t
  :init (evil-mode t)
  :config (evil-set-undo-system 'undo-tree))


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

(defun cycle-themes ()
  (interactive)
  (setq theme-index (% (+ 1 theme-index) (length themes)))
  (load-theme (nth theme-index themes)))
(global-set-key [C-escape] 'cycle-themes)
  
(global-set-key (kbd "M-j") '(lambda () (interactive) (evil-next-line 2)))
(global-set-key (kbd "M-k") '(lambda () (interactive) (evil-previous-line 2)))
(global-set-key (kbd "C-j") '(lambda () (interactive) (evil-scroll-line-down 2)))
(global-set-key (kbd "C-k") '(lambda () (interactive) (evil-scroll-line-up 2)))
(global-set-key (kbd "M-e") 'eval-expression)
(global-set-key (kbd "C-M-e") 'eval-buffer)


;; Save backups in a separate directory
(setq backup-directory-alist '((".*" . "~/.Trash/")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6bdcff29f32f85a2d99f48377d6bfa362768e86189656f63adbf715ac5c1340b" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(package-selected-packages
   '(magit flycheck lsp-ui lsp-java dirtree counsel evil restclient geiser-mit use-package smooth-scroll)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
