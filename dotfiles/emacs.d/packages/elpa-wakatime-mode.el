;; Log working time on wakatime.com
(if (file-exists-p "/usr/local/bin/wakatime") (use-package wakatime-mode
    :ensure t
    :delight wakatime-mode " Ϣ"
    :config (progn
        (setq
            wakatime-cli-path "/usr/local/bin/wakatime"
            wakatime-python-bin "/usr/local/bin/python"
        )
        (global-wakatime-mode 1)
    )
))

(provide 'elpa-wakatime-mode)
