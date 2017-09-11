;; Smart pairs
(use-package smartparens
    :ensure t
    :delight smartparens-mode
    :config (progn
        (require 'smartparens-config)
        (add-hook 'prog-mode-hook 'smartparens-mode)
    )
)

(provide 'elpa-smartparens)
