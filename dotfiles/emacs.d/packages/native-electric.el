;; Automate behaviour
(use-package electric
    ;; TODO: Find out more about this module so it actually does something.
    :demand t
    :config (progn
        (electric-indent-mode -1); when pressing return auto-indent will be disabled
    )
)

(provide 'native-electric)
