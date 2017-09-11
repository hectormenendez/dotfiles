;; Replace the word lambda with the greek character (without using pretty symbols)
(use-package pretty-lambdada
    :ensure t
    :config (progn
        (add-hook 'prog-mode-hook 'pretty-lambda-mode)
    )
)

(provide 'elpa-pretty-lambdada)
