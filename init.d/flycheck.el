(use-package flycheck
  :ensure t
  :defer 3
  :functions global-flycheck-mode
  :preface (declare-function flycheck-mode-on-safe "ext:flycheck")
  :init
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (global-flycheck-mode))
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
