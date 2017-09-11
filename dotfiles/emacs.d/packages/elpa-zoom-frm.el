;; Use common key-bindings for zooming the frame.
(use-package zoom-frm
    :ensure t
    :if window-system
    :config (progn
        (setq zoom-frame/buffer 'buffer)
        ;; Disable default text-scaling (it messes up with FCI)
        (global-set-key (kbd "C-x C-0") nil)
        (global-set-key (kbd "C-x C-=") nil)
        (global-set-key (kbd "C-x C-+") nil)
        (global-set-key (kbd "C-x C--") nil)
        ;; Now setup the bindings with the zoom plugin
        (global-set-key (kbd "M-0") 'zoom-frm-unzoom)
        (global-set-key (kbd "M-+") 'zoom-frm-in)
        (global-set-key (kbd "M--") 'zoom-frm-out)
    )
)

(provide 'elpa-zoom-frm)
