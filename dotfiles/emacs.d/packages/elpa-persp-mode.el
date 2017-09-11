;; Workspace management via perspectives
(use-package persp-mode
    :ensure t
    :delight persp-mode
    :config (progn
        (setq
            persp-autokill-buffer-on-remove 'kill ; kill the buffer when closed
            persp-nil-name "nil"; The name of the default perspective
            persp-save-dir "~/.emacs.d/_perspectives/"
            persp-auto-save-fname "autosave"
            persp-set-last-persp-for-new-frames nil; don't use last persp for new frames
            persp-auto-save-opt 1; Auto-save perspective on buffer kill
            persp-auto-resume-time 1; Load perspectives on startup
            persp-nil-hidden t; hide the nil perspective
        )
        ;; Integrate with projectile
        (use-package persp-mode-projectile-bridge
            :ensure t
            :config (add-hook 'persp-mode-projectile-mode-hook '(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                    (persp-mode-projectile-bridge-kill-perspectives)
                )
            ))
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            (evil-leader/set-key "TAB" 'persp-switch);; quick perspective switch
            (global-set-key (kbd "C-b") nil); backward_char
            (global-set-key (kbd "C-b") 'persp-switch-to-buffer)
            (global-set-key (kbd "C-B") 'persp-kill-buffer)
            (global-set-key (kbd "M-w") nil); kill-ring-save
            (global-set-key (kbd "M-w") 'kill-this-buffer)
        ))
        (with-eval-after-load "persp-mode"
            ;; always kill buffer using persp-mode
            (substitute-key-definition 'kill-buffer 'persp-kill-buffer global-map)
        )
        (persp-mode 1)
    )
)

(provide 'elpa-persp-mode)
