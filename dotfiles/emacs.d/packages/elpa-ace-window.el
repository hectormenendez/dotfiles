;; Allows easier movement from window to window
(use-package ace-window
    :ensure t
    :delight ace-window-mode
    :config (progn
        ;; Set the font-face for the ace-window indicator
        (custom-set-faces
            '(aw-leading-char-face ((t (
                :inherit ace-jump-face-foreground
                :foreground "#FFFFFF"
                :height 3.0))
            ))
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Replace "other-window"
            (global-set-key [remap other-window] 'ace-window)
            ;; Disable the usual bindings for window management
            (global-set-key (kbd "C-x 0") nil); closes window
            (global-set-key (kbd "C-x 1") nil); delete other windows
            (global-set-key (kbd "C-x 2") nil); splits window horizontally
            (global-set-key (kbd "C-x 3") nil); splits window vertically
            ;; when splitting windows, always balance windows
            (evil-leader/set-key "w|" '(lambda ()
                (interactive)
                (split-window-horizontally)
                (balance-windows)
                (other-window 1 nil)
            ))
            (evil-leader/set-key "w-" (lambda ()
                (interactive)
                (split-window-vertically)
                (balance-windows)
                (other-window 1 nil)
            ))
            ;; Key bindings for evil-mode
            (evil-leader/set-key "ww" 'ace-window)
            (evil-leader/set-key "wh" 'windmove-left)
            (evil-leader/set-key "wj" 'windmove-down)
            (evil-leader/set-key "wk" 'windmove-up)
            (evil-leader/set-key "wl" 'windmove-right)
            (evil-leader/set-key "wq" 'delete-window)
            (evil-leader/set-key "wo" 'delete-other-windows)
            (evil-leader/set-key "w=" 'balance-windows)
        ))
    )
)

(provide 'elpa-ace-window)
