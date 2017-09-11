;; Auto update files when modified outside Emacs
(use-package autorevert
    ;; Update buffers whenever the file changes on disk
    :delight (auto-revert-mode)
    :config (progn
        (setq
            auto-revert-verbose nil
            global-auto-revert-non-file-buffers t; Enable autorevert on dired buffers
        )
        (global-auto-revert-mode 1)
    )
)

(provide 'native-autorevert)
