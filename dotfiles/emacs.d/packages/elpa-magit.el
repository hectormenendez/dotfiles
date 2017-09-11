;; Enable version control using Magit (fugitive alternative)
(use-package magit
    :ensure t
    :config (add-hook 'evil-local-mode-hook '(lambda ()
        (evil-leader/set-key "gs" 'magit-status)
        (evil-leader/set-key "gc" 'magit-commit)
        (evil-leader/set-key "gp" 'magit-push)
        (evil-leader/set-key "gd" 'vc-diff)
        (evil-leader/set-key "g+" 'git-gutter:stage-hunk)
        (evil-leader/set-key "g-" 'git-gutter:revert-hunk)
        (evil-leader/set-key "g}" 'git-gutter:next-hunk)
        (evil-leader/set-key "g{" 'git-gutter:previous-hunk)
    ))
)

(provide 'elpa-magit)
