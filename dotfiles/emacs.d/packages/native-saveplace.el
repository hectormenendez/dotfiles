;; Save the cursor position for every file.
(use-package saveplace
    :demand t
    :config (progn
        (setq save-place-file "~/.emacs.d/_saveplace")
        (save-place-mode 1)
    )
)

(provide 'native-saveplace)
