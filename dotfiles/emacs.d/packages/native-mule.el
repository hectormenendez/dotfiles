;; Multilingual support (set everything to utf-8, basically)
(use-package mule
    :demand t
    :config (progn
        (setq
            locale-coding-system 'utf-8
            buffer-file-coding-system 'utf-8
        )
        (prefer-coding-system 'utf-8)
        (set-charset-priority 'unicode)
        (set-language-environment 'utf-8)
        (set-default-coding-systems 'utf-8)
        (set-terminal-coding-system 'utf-8)
        (set-keyboard-coding-system 'utf-8)
        (set-selection-coding-system 'utf-8)
    )
)

(provide 'native-mule)
