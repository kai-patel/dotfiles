;;; emacs --- KP Emacs Config (Evil Mode)

;;; Commentary:
;;  A basic init file written by KP

;;; Code:

(load-theme 'gruber-darker t) ; theme

;;; Menu bars
(tool-bar-mode 0) ; no tool bar
(menu-bar-mode 0) ; no menu bar

(show-paren-mode 1) ; visualize matching parenthesees
(global-hl-line-mode 1) ; highlight current line(require 'package)

(setq inhibit-startup-screen 1) ; no start screen
(fset 'yes-or-no-p 'y-or-n-p) ; y/n instead of yes/no

;;; Font face
(set-frame-font "Fira Code Retina 12" nil t)

;;; Line numbers
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; Indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4) ; assert equal c-basic-offset tab-width

;;; Disable auto-indent for org-mode
(add-hook 'org-mode-hook
          (lambda () (electric-indent-local-mode -1)))

;;; Change backup file storage location
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;;; Add MELPA repo and refresh
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; Undo-Tree
(use-package undo-tree
  :ensure t
  :init
  (require 'undo-tree)
  :config
  (global-undo-tree-mode))

;;; Evil-mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1))

;;; Extended evil mode bindings
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;; Projectile (project management)
(use-package projectile
  :ensure t
  :config
  (projectile-mode))

;;; Helm projectile support
(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; Smartparens
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode))

;;; Helm
(use-package helm
  :ensure t
  :init
  (require 'helm-config)
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (helm-mode 1))

;;; Company-mode (Autocomplete)
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t))

;;; Multiple Cursors
(use-package multiple-cursors
  :ensure t
  :init
  (require 'multiple-cursors)
  :config
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;;; Org-mode
(use-package org
  :ensure t
  :init
  (require 'org)
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t))

;;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (require 'flycheck)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq flycheck-python-flake8-executable "python")
  (setq flycheck-python-pycompile-executable "python")
  (setq flycheck-python-pylint-executable "python")
  (global-flycheck-mode))

;;; Whitespace
(require 'whitespace)
(setq whitespace-style '(face tabs spaces trailing indentation hspace space-mark tab-mark))
(whitespace-mode 1)

;;; Ido mode
(setq ido-enable-flex-matching t)
(ido-mode 1)

;;; Haskell mode
(use-package haskell-mode
  :ensure t
  :init
  (require 'haskell-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   '("5f824cddac6d892099a91c3f612fcf1b09bb6c322923d779216ab2094375c5ee" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(haskell-mode whitespace ido ido-mode flycheck gruber-darker-theme company use-package undo-tree evil evil-collection multiple-cursors)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)

;;; .emacs ends here
