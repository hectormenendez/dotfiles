;; Enable Javascript mode
(use-package js2-mode
    :ensure t
    :interpreter "node"
    :mode (("\\.js\\'" . js2-mode))
    :config (progn
        (use-package simple-httpd :ensure t)
        (use-package skewer-mode
            :ensure t
            :delight skewer-mode
            :config (progn
                (add-hook 'js2-mode-hook 'skewer-mode)
                (add-hook 'css-mode-hook 'skewer-css-mode)
                (add-hook 'html-mode-hook 'skewer-html-mode)
            )
        )
        ;; Enable contex-sensitive auto-completion (depends on skewer-mode too)
        (use-package ac-js2
            :ensure t
            :config (progn
                (setq ac-js2-evaluate-calls t)
                (add-hook 'js2-mode-hook 'ac-js2-mode)
            )
        )
        ;; Enable tern
        (use-package tern
            :ensure t
            :config (progn
                (add-hook 'js2-mode-hook 'tern-mode)
                (setq-default tern-command (append tern-command '("--no-port-file")))
                ;; Add tern to copany backends.
                (use-package company-tern
                    :ensure t
                    :init (add-to-list 'company-backends 'company-tern)
                    :config (setq company-tern-property-marker nil)
                )
            )
        )
        (setq-default
            js2-basic-offset 4
            js2-highlight-level 3
            js2-auto-indent-p t
            js2-indent-switch-body t
            js2-indent-on-enter-key t
            js2-include-browser-externs t
            js2-include-node-externs t
            js2-warn-about-unused-function-arguments t
            ;; let flycheck handle parse errors
            js2-mode-show-parse-errors nil
            js2-strict-missing-semi-warning nil
            js2-strict-trailing-comma-warning nil
            js2-strict-cond-assign-warning nil
            js2-strict-inconsistent-return-warning nil
            js2-strict-var-hides-function-arg-warning nil
            js2-strict-var-redeclaration-warning nil
        )
        (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
    )
)

(provide 'elpa-js2-mode)
