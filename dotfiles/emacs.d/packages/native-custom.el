;; Customisations (mostly themes)
(use-package custom
    ;; TODO: validate the existence of the theme before trying to load it
    :demand t
    :config (progn
        (setq
            custom-safe-themes t; Don't ask for confirmations when loading themes
            custom-file "~/.emacs.d/_custom.el"; Save customisations to this file
        )
        (add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/"); Themes location
        (load custom-file)
    )
)

(provide 'native-custom)
