(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

(use-package irony
  :commands irony-install-server
  :init
  (setq-default irony-cdb-compilation-databases '(irony-cdb-clang-complete
                                                  irony-cdb-libclang))
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  :config
  (use-package company-irony
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
  (use-package flycheck-irony
    :after flycheck
    :config
    (add-hook 'irony-mode-hook #'flycheck-irony-setup)))
