;; Indentation lines!
(use-package highlight-indent-guides
    :ensure t
    :delight highlight-indent-guides-mode
    :config (progn
        (setq highlight-indent-guides-method 'character)
        (setq highlight-indent-guides-auto-enabled nil); don't calculate color
        (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    )
)

(provide 'elpa-highlight-indent-guides)
