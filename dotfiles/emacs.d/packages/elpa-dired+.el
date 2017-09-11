;; Improve default functionality for dired
(use-package dired+
    :ensure t
    :config (progn
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Add jump to current file's folder
            (global-set-key (kbd "C-x C-j") nil);original binding
            (evil-leader/set-key "." 'dired-jump)
        ))
        ;;Use evil on dired mode
        (eval-after-load 'dired '(lambda ()
            (add-hook 'evil-local-mode-hook '(lambda ()
                (evil-make-overriding-map dired-mode-map 'normal t); the standard bindings
                (evil-define-key 'normal dired-mode-map
                    "h" 'evil-backward-char
                    "j" 'evil-next-line
                    "k" 'evil-previous-line
                    "l" 'evil-forward-char
                    "w" 'evil-forward-word-begin
                    "b" 'evil-backward-word-begin
                )
            ))
        ))
        ;; reuse the dired buffer when moving between directories
        (diredp-toggle-find-file-reuse-dir 1)
    )
)

(provide 'elpa-dired+)
