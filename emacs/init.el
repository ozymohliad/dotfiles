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
(load-theme 'misterioso) ; color scheme
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
(require 'smooth-scroll)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(restclient geiser-mit use-package smooth-scrolling smooth-scroll)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(smooth-scrolling-mode t) ; scroll screen when cursor is nearits edge
