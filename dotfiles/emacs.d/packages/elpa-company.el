;; Autocompletion
(use-package company
    :ensure t
    :delight company-mode
    :config (progn
        ;; Enable company in any programming mode
        (add-hook 'prog-mode-hook 'company-mode)
    )
)

(provide 'elpa-company)
