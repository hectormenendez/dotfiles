;; enable jump-to definition
(use-package dumb-jump
    :ensure t
    :config (progn
        (setq-default
            dumb-jump-prefer-searcher 'ag
            dumb-jump-selector 'helm
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Key bindings for evil-mode
            (evil-leader/set-key "jj" 'dumb-jump-go)
            (evil-leader/set-key "jJ" 'dumb-jump-back)
        ))
        (add-hook 'prog-mode-hook 'dumb-jump-mode)
    )
)

(provide 'elpa-dumb-jump)
