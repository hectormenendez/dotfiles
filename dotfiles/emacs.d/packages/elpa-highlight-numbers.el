;; Wait what? numbers don't get a highlight on emacs? fix it.
(use-package highlight-numbers
    :ensure t
    :delight highlight-numbers-mode
    :config (add-hook 'prog-mode-hook 'highlight-numbers-mode)
)

(provide 'elpa-highlight-numbers)
