;;; ...  -*- lexical-binding: nil -*-

(set-default 'truncate-lines t)
(global-unset-key (kbd "C-u"))
(setq make-backup-files nil)
(setq create-lockfiles nil)
(delete-selection-mode 1)
(global-subword-mode 1)
(global-auto-revert-mode t)
(setq desktop-path '("./"))
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(menu-bar-mode -1)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-level 2)
 '(go-indent-level 2)
 '(js-indent-level 2)
 '(js2-bounce-indent-p t)
 '(package-selected-packages '(company markdown-mode yasnippet zig-mode))
 '(python-indent-offset 2))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-ts-mode))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zon\\'" . zig-mode))

;; ---------------------------------------------------------------- eglot

(require 'project)
(require 'company)
(require 'yasnippet)
(require 'eglot)

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1))))


;; ---------------------------------------------------------------- Go

(add-hook 'go-ts-mode-hook 'eglot-ensure)

(defun project-find-go-module (dir)
  (when-let* ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(defun eglot-format-buffer-before-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
(add-hook 'go-ts-mode-hook #'eglot-format-buffer-before-save)

(setq-default eglot-workspace-configuration
    '((:gopls .
        ((staticcheck . t)
         (matcher . "CaseSensitive")))))

;; ---------------------------------------------------------------- Rust

(add-hook 'rust-ts-mode-hook 'eglot-ensure)

(add-to-list 'eglot-server-programs
             '((rust-ts-mode) .
               ("rust-analyzer" :initializationOptions (:check (:command "clippy")))))

;; ---------------------------------------------------------------- Zig

(add-hook 'zig-mode-hook 'eglot-ensure)

(add-to-list 'eglot-server-programs
             '((zig-mode) .
               ("zls")))

;; ---------------------------------------------------------------- TS

(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'js-ts-mode-hook 'eglot-ensure)

(add-to-list 'eglot-server-programs
             '((typescript-ts-mode :language-id "typescriptreact")
               (js-ts-mode :language-id "javascript")
               . ("typescript-language-server" "--stdio")))

(setq eglot-workspace-configuration
      '(:typescript (:inlayHints (:includeInlayParameterNameHints "all"
                                                                  :includeInlayVariableTypeHints t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ---------------------------------------------------------------- Theme

(let ((inhibit-redisplay t))
  ;; Disable all active themes
  (mapc #'disable-theme custom-enabled-themes)
  ;; Load the built-in theme
  (load-theme 'modus-vivendi t))
