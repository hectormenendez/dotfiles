;; Enable multiple cursosr handling
(use-package multiple-cursors
    :ensure t
    :config (with-eval-after-load 'evil (progn
        ;; Don't exit multiple cursors with return, use C-g instead
        (define-key mc/keymap (kbd "<return>") nil)
        ;; Replace these evil-map
        (define-key evil-normal-state-map (kbd "C-n") 'mc/mark-next-like-this-symbol)
        (define-key evil-normal-state-map (kbd "C-p") 'mc/mark-previous-like-this-symbol)
        (define-key global-map (kbd "<C-down>") 'mc/mark-next-like-this)
        (define-key global-map (kbd "<C-up>") 'mc/mark-previous-like-this)
        (define-key global-map (kbd "<C-right>") 'mc/edit-ends-of-lines)
        (define-key global-map (kbd "<C-left>") 'mc/edit-beginnings-of-lines)
        ;; evil-leader keys
        (evil-leader/set-key "c*" 'mc/mark-all-like-this)
        (evil-leader/set-key "cc" 'mc/edit-lines)
        (evil-leader/set-key "c$" 'mc/edit-ends-of-lines)
        (evil-leader/set-key "cn" 'mc/mark-next-like-this-symbol)
        (evil-leader/set-key "cp" 'mc/mark-previous-like-this-word)
        (evil-leader/set-key "c{" 'mc/cycle-backward)
        (evil-leader/set-key "c}" 'mc/cycle-forward)
        (evil-leader/set-key "cx" 'mc/skip-to-next-like-this)
        (evil-leader/set-key "cX" 'mc/skip-to-previous-like-this)
        ;; Don't ask for confirmation on evil commands
        (setq mc/cmds-to-run-for-all '(
            evil-insert
            evil-change
            evil-normal-state
            evil-append-line
            evil-delete-line
            evil-forward-WORD-begin
            evil-forward-WORD-end
            evil-forward-word-begin
            evil-forward-word-end
            evil-backward-WORD-begin
            evil-backward-WORD-end
            evil-backward-word-begin
            evil-backward-word-end
            evil-end-of-line
            evil-first-non-blank
            evil-find-char
            evil-find-char-backward
            evil-find-char-to
            evil-find-char-to-backward
            evil-next-line
            evil-previous-line
            evil-delete-char
            yank-rectagle
            copy-region-as-kill; used for multiple selection copy
        ))
    ))
)

(provide 'elpa-multiple-cursors)
