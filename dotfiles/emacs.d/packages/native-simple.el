;; Basic editor configuration
(use-package simple
    :demand t
    :config (progn
        (column-number-mode 1); Show the current-column number
        (global-hl-line-mode 1); Highlight the current line
    )
)

(provide 'native-simple)
