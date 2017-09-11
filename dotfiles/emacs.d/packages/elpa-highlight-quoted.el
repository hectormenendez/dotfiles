;; What? no highlighted quotes for lisp either? c'mon man!
(use-package highlight-quoted
    :ensure t
    :delight highlight-quoted-mode
    :config (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
)

(provide 'elpa-highlight-quoted)
