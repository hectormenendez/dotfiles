;; Add an indicator at the fill-column position.
(use-package fill-column-indicator
    :ensure t
    :delight fci-mode
    :config (progn
        (setq fci-rule-width 1)
        (add-hook 'prog-mode-hook 'fci-mode)
    )
)

(provide 'elpa-fill-column-indicator)
