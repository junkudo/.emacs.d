(use-package company
  :ensure t
  :defer 0
  :bind ("M-RET" . company-complete)
  :functions global-company-mode
  :preface (declare-function company-mode-on "ext:company")
  :init
  (add-hook 'after-init-hook #'global-company-mode)
  :config
  (setq company-selection-wrap-around t)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)
  )
