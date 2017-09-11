;; Show invalid whitespaces
(use-package whitespace
    :demand t
    :delight (global-whitespace-mode)
    :init (setq-default ;; These are core & indent vars
        fill-column 90
        tab-width 4; Use 4 spaces as indentation
        indent-tabs-mode nil; Use spaces for tabs
        tab-always-indent t; The tab key will always indent (duh)
        tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88)
    )
    :config (progn
        (setq-default
            whitespace-style '(face tabs tab-mark trailing lines-tail); Highlight these
            whitespace-line-column fill-column; Use the fill-column to mark overflowed
            whitespace-display-mappings '(; Customize the look of these character
                (tab-mark ?\t [?› ?\t])
                (newline-mark 10  [36 10])
            )
        )
        (global-whitespace-mode 1)
    )
)

(provide 'native-whitespace)
