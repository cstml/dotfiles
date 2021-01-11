(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")   ;some problem idk what - but it fixed it
(package-initialize)

 ;; rainbow delimeters mode 
(add-hook 'foo-mode-hook #'rainbow-delimiters-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-completion-style (quote emacs))
 '(org-agenda-files (quote ("~/cdng/Obsidian/org-mode/")))
 '(package-selected-packages
   (quote
    (projectile fzf gradle-mode eclim helm-ls-git helm use-package ## web-mode tide docker-compose-mode dockerfile-mode neotree latex-preview-pane sly typescript-mode magit evil cider alect-themes paredit slime slime-volleyball rainbow-delimiters))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;paredit for nice paranthesis
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook                  #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook                        #'enable-paredit-mode)
(add-hook 'lisp-mode-hook                        #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook            #'enable-paredit-mode)
(add-hook 'scheme-mode-hook                      #'enable-paredit-mode)
(add-hook 'clojure-mode-hook                     #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; ---------------------------------------------------------
;; dark theme
(load-theme 'alect-black t)

;; ---------------------------------------------------------
;;slime
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;; ---------------------------------------------------------
;; check OS type
;; because the Mac OS Keyboard - doesn't work well
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Microsoft Windows")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil)
    (message "Mac OS X")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))
(setq mac-right-option-modifier nil)

;; line wrap at 80
(setq-default fill-column 80)

;; cider for Clojure
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; dockerfile-mode
(use-package dockerfile-mode)
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; docker-compose mode
(use-package docker-compose-mode)
(require 'docker-compose-mode)

;; ---------------------------------------------------------
;; TIDE Typescript
(use-package web-mode)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; ---------------------------------------------------------
;; TIDE TSX
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
;; (flycheck-add-mode 'typescript-tslint 'web-mode)

;; ---------------------------------------------------------
;; TIDE JSX
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
;; (flycheck-add-mode 'javascript-eslint 'web-mode)
;;  (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)


;; ---------------------------------------------------------
;; TIDE use package
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))


;; ---------------------------------------------------------
;; HELM for completion
(use-package helm)
(global-set-key (kbd "M-x") 'helm-M-x)            ;; binds M-x to `helm-M-x
(global-set-key (kbd "C-x C-f") 'helm-find-files) ;; binds the helm file search
(helm-mode 1) ;; to turn on helm-mode
(require 'helm-ls-git) ;; helm seeing all files in git project
(global-set-key (kbd "C-x C-d") 'helm-browse-project) ;; bind instead of dir

;; turn evil mode on by default
;(require 'evil)
;(evil-mode 1)

;; turn emacs server on to connect with client 
(server-start)

;; ---------------------------------------------------------
;; good ol' fzf
(use-package fzf)
(global-set-key (kbd "C-x M-f") 'fzf-git)        ;; fzf-find-git
(global-set-key (kbd "C-x M-f M-f") 'fzf-git-grep) ;; fzf
