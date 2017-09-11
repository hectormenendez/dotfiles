;; Make sure Mac's $PATH is available to emacs
(use-package exec-path-from-shell
    :ensure t
    :if (file-exists-p "/usr/local/bin/bash")
    :init (setenv "SHELL" "/usr/local/bin/bash")
    :config (progn
        (setq
            exec-path-from-shell-check-startup-files nil; remove warning
            exec-path-from-shell-variables '("PATH" "MANPATH")
        )
        (exec-path-from-shell-initialize)
    )
)

(provide 'elpa-exec-path-from-shell)
