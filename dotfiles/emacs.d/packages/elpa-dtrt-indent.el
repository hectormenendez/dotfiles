;; Try to guess the current file indentation and set emacs to follow it
(use-package dtrt-indent
    :ensure t
    :delight dtrt-indent-mode " [dtrt] "
    :config (add-hook 'prog-mode-hook 'dtrt-indent-mode)
)

(provide 'elpa-dtrt-indent)
