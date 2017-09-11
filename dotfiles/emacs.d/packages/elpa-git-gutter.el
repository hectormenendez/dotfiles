;; Adds a gutter with the git status of each file (duh)
(use-package git-gutter
    :ensure t
    :delight git-gutter-mode
    :config (progn
        (git-gutter:linum-setup); play along with linum-mode
        (setq git-gutter:update-interval 2); Update git gutter after n secs idle
        (setq git-gutter:ask-p nil); Don't ask confirmation when committing or reverting
        (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
        (add-to-list 'git-gutter:update-hooks 'magit-post-refresh-hook)
        (add-to-list 'git-gutter:update-hooks 'git-gutter:post-command-hook)
        (add-hook 'prog-mode-hook 'git-gutter-mode)
    )
)

(provide 'elpa-git-gutter)
