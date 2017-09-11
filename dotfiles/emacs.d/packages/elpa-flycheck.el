;; Syntax checking
(use-package flycheck
    :ensure t
    :init (setq-default flycheck-disabled-checkers (append '(
        javascript-jshint
        javascript-jscs
        javascript-standard
    )))
    :config (progn
        (setq
            flycheck-temp-prefix ".flycheck"
            flycheck-mode-line-prefix " ✖︎"
        )
        (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
        (flycheck-add-mode 'javascript-eslint 'js2-mode)
        (add-hook 'prog-mode-hook 'global-flycheck-mode)
    )
)

(provide 'elpa-flycheck)
