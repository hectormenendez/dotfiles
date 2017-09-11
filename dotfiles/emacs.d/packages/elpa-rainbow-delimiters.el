;; Use different colors for parenthesis to ease matching
(use-package rainbow-delimiters
    :ensure t
    :config (progn
        (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    )
)

(provide 'elpa-rainbow-delimiters)
