;; Relative line-numbers
(use-package linum-relative
    :ensure t
    :delight linum-relative-mode
    :config (add-hook 'prog-mode-hook (lambda ()
        (add-hook 'linum-mode-hook (lambda ()
            (setq
                linum-relative-current-symbol ""; Show the current line-number
                linum-relative-format " %3s"; Add some spaces to numbers
            )
            (linum-relative-mode 1)
        ))
        (linum-mode 1)
    ))
)

(provide 'elpa-linum-relative)
