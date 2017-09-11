;; Track opened files
(use-package recentf
    :demand t
    :config (progn
        (setq
            recentf-save-file "~/.emacs.d/_recentf"
            recentf-filename-handlers '(abbreviate-file-name)
        )
        (recentf-mode 1)
    )
)

(provide 'native-recentf)
