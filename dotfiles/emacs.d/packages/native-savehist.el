;; History
(use-package savehist
    :demand t
    :config (progn
        (setq
            savehist-file "~/.emacs.d/_history"
            savehist-save-minibuffer-history 1
            history-length t
            history-delete-duplicates t
        )
        (savehist-mode 1)
    )
)

(provide 'native-savehist)
