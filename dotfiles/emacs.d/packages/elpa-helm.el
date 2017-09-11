;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :delight helm-mode
    :config (progn
        (require 'helm-config)
        ;; Make sure helm-silver-searcher is installed
        (use-package helm-ag :ensure t)
        ;; Enable fuzzy matching
        (setq-default
            helm-candidate-number-limit 100
            helm-mode-fuzzy-match t
            helm-completion-in-region-fuzzy-match t
            helm-autoresize-mode t
            helm-buffer-max-length 50
            ;; Try to update faster when hitting RET too quickly
            helm-idle-delay 0.0
            helm-input-idle-delay 0.0
            helm-yas-display-key-on-candidate t
            helm-quick-update t
            helm-M-x-requires-pattern nil
            helm-ff-skip-boring-files t
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            (evil-leader/set-key "DEL" 'helm-mini)
            (evil-leader/set-key "SPC" 'helm-M-x)
            ;; Map the helm help
            (global-set-key (kbd "C-x c a") nil); The original helm-apropos binding
            (global-set-key (kbd "C-h C-h") nil); The emacs help for help
            (global-set-key (kbd "C-h C-h") 'helm-apropos)
            ;; Map the dynamic kill-ring
            (global-set-key (kbd "M-v") nil); The scroll-down-command
            (global-set-key (kbd "C-x c M-y") nil); The original helm-show-kill-ring
            (global-set-key (kbd "M-v") 'helm-show-kill-ring)
            ;; Map the dynamic-text search
            (global-set-key (kbd "C-s") nil); isearch-forward
            (global-set-key (kbd "C-s") 'helm-occur)
        ))
        ; Disable the "I Do" mode, we have helm for that now.
        (ido-mode -1)
        (helm-mode 1)
    )
)

(provide 'elpa-helm)
