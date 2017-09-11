;; VI rocks! there, I said it.
(use-package evil
    :ensure t
    :config (progn
        ;; Enable tpope's vim-commentary port
        (use-package evil-commentary
            :ensure t
            :delight evil-commentary-mode
        )
        ;; Enable tpope's vim-surround port (globally)
        (use-package evil-surround
            :ensure t
            :delight evil-surround-mode
            :config (global-evil-surround-mode 1)
        )
        ;; Enable the <leader> key like in Vim
        (use-package evil-leader
            :ensure t
            :config (global-evil-leader-mode 1)
        )
        ;; Enable comentary mode only on programming mode
        (add-hook 'prog-mode-hook 'evil-commentary-mode)
        ;; To avoid issues load these after emacs has initialized
        (add-hook 'evil-mode-hook '(lambda ()
            (evil-leader/set-leader "SPC")
            (evil-leader/set-key "?" 'which-key-show-top-level)
            (evil-leader/set-key "y" 'copy-region-as-kill); copy selection
            (evil-leader/set-key "p" 'yank-rectangle); paste selection
            ;; Have <tab> to work as it does on Vim
            (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
            (define-key evil-motion-state-map (kbd "C-b") nil); scroll down
            ;; Auto indent after paste
            (fset 'indent-pasted-text "`[v`]=")
        ))
        ;; Enable evil-mode baby!
        (evil-mode 1)
    )
)

(provide 'elpa-evil)
