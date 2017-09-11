;; Smart region seletion
(use-package expand-region
    :ensure t
    :config (add-hook 'evil-mode-hook (lambda ()
        (evil-leader/set-key "v" 'er/expand-region)
    ))
)

(provide 'elpa-expand-region)
