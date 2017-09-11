;; Show a file-tree ala Vim
(use-package neotree
    :ensure t
    :config (progn
        ;; Enable theme
        (use-package all-the-icons :ensure t)
        (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
        ;; Use ffip to determine the project root and open neotree relative to it.
        (use-package find-file-in-project
            :ensure t
            :config (add-hook 'evil-local-mode-hook '(lambda ()
                (evil-leader/set-key "RET" (lambda ()
                    (interactive)
                    (let
                        (
                            (project-dir (ffip-project-root))
                            (file-name (buffer-file-name))
                        )
                        (if project-dir
                            (progn
                                (neotree-dir project-dir)
                                (neotree-find file-name)
                            )
                            (message "Could not find git project root.")
                        )
                    )
                ))
            ))
        )
        ;; (evil-define-ket 'normal neotree-mode-map (kbd "|") 'neotree-)
        (setq neo-smart-open t); let neotree find the current file and jump to it.
        ;; work along with projectile
        (setq projectile-switch-project-action 'neotree-projectile-action)
        ;; Don't show hidden files (they will be excluded by git)
        (setq-default neo-show-hidden-files nil)
        ;; overwrite the default hidden file filter, so it uses .gitignore
        (defun neo-util--hidden-path-filter (node)
            "it reads each nodule on the list, and determines if its ignored by git."
            (if neo-buffer--show-hidden-file-p
                ;; all files should be shown
                node
                ;; hiding is enabled, use git check-ignore to determeine which to show
                (if
                    ;; if the output is empty (file should be shown) return the node
                    (string= (string-trim (shell-command-to-string (format
                        "git -C %s check-ignore %s"
                        (file-name-directory node)
                        node
                    ))) "")
                    node
                    ;; git outputed something, file shold be hidden
                    nil
                )
            )
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Allow to use evil mode with neotree
            (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
            (evil-define-key 'normal neotree-mode-map (kbd "<f5>") 'neotree-refresh)
            (evil-define-key 'normal neotree-mode-map (kbd "<escape>") 'neotree-toggle)
            (evil-define-key 'normal neotree-mode-map (kbd "m") 'neotree-rename-node)
            (evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
            (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-create-node)
        ))
    )
)

(provide 'elpa-neotree)
