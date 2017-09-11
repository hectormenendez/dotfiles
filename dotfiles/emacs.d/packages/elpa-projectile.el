;; Quick switching files
(use-package projectile
    :ensure t
    :delight projectile-mode
    :config (progn
        ;; Enable helm-projectile-integration
        (use-package helm-projectile :ensure t)
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; make C-/ trigger helm-ag instead of undo-tree's undo
            (define-key undo-tree-map (kbd "C-/") nil); undo-tree-undo
            (global-set-key (kbd "C-/") 'helm-projectile-ag)
            ;; Enable helm-projectile
            (define-key evil-motion-state-map (kbd "C-f") nil); scroll up
            (global-set-key (kbd "C-f") 'helm-projectile)
            ;; Enable finding directories
            (define-key evil-motion-state-map (kbd "C-d") nil); scroll down
            (global-set-key (kbd "C-d") 'helm-projectile-find-dir)
        ))
        (setq projectile-cache-file
            (expand-file-name "_projectile/cache" user-emacs-directory)
        )
        (setq projectile-known-projects-file
            (expand-file-name "_projectile/known_projects" user-emacs-directory)
        )
        (projectile-mode 1)
    )
)

(provide 'elpa-projectile)
