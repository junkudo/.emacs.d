(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode)) ;CUDA
;; QMake makefiles
(add-to-list 'auto-mode-alist '("\\.pro\\'" . makefile-mode))

(use-package find-file
  :defer t
  :init (setq-default ff-always-in-other-window t))

(use-package cc-mode
  :bind (:map c-mode-base-map
              ("C-c t" . ff-find-other-file))
  :preface
  (defun sarcasm-set-c++-cc-style ()
    "Personalized cc-style for c++ mode."
    (c-set-offset 'innamespace 0))
  :config
  (add-hook 'c++-mode-hook #'sarcasm-set-c++-cc-style)

)

(use-package clang-format
  :ensure t
  :after cc-mode
  :defines c-mode-base-map
  :bind (:map c-mode-base-map ("C-S-f" . clang-format-region))
  :config)

(use-package irony
  :ensure t
  :commands irony-mode
  :after cc-mode
  :init
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (setq irony--compile-options
      '("-std=c++11"))
  (use-package company-irony
    :ensure t
    :after company
    :config
    (setq company-irony-ignore-case 'smart)
    (add-to-list 'company-backends 'company-irony)
    (use-package company-c-headers
      :ensure t
      :functions irony--extract-user-search-paths company-c-headers
      :preface
      (defun company-c-headers-path-user-irony ()
        "Return the user include paths for the current buffer."
        (when irony-mode
          (irony--extract-user-search-paths irony--compile-options
                                            irony--working-directory)))
      :config
      (setq company-c-headers-path-user #'company-c-headers-path-user-irony)
      (add-to-list 'company-backends #'company-c-headers)))
  )

(use-package flycheck-irony
    :ensure t
    :config (add-hook 'irony-mode-hook 'flycheck-irony-setup))
