;; Enable Emacs server so clients can connect to current session
(use-package server
    :demand t
    :config (add-hook 'after-init-hook '(lambda ()
        (unless (server-running-p) (server-start))
    ))
)

(provide 'native-server)
