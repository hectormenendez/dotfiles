;; Highlight TODOs
(use-package hl-todo
    :ensure t
    :init (add-hook 'prog-mode-hook 'hl-todo-mode)
    :bind (
        ("C-c t n" . hl-todo-next)
        ("C-c t p" . hl-todo-previous)
        ("C-c C-t" . hl-todo-occur)
    )
)

(provide 'elpa-hl-todo)
