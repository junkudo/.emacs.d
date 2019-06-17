(require 'package)
(setq package-enable-at-startup nil   ;Info node `(emacs) Package Installation'
      ;; prefer melpa-stable, then the default source gnu, then others
      package-archive-priorities '(("gnu"          . 10)
                                   ("melpa-stable" . 5))
      package-pinned-packages '((use-package . "melpa")))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; NOTE: this call is probably the more expensive function call of the init file
;; but this is also the building block for the rest of the configuration
(package-initialize)

;; Configure and bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(dolist (el-file (directory-files
                  (expand-file-name "init.d" user-emacs-directory) t
                  "^[^.].*\\.el$"))
  ;; load filename sans extension so that `load' tries byte compile init files
  (let ((load-prefer-newer t))
      (load (file-name-sans-extension el-file) nil t)))
