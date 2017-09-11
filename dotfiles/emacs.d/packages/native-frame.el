;; Customize frame behaviour (only when in GUI mode)
(use-package frame
    ;; TODO: framegeometry load and save should be a plugin
    :if window-system
    :bind (
        ("M-RET" . toggle-frame-fullscreen)
    )
    :config (progn
        (setq frame-title-format "emacs")
        (tool-bar-mode -1); Don't show the toolbar
        (scroll-bar-mode -1); Don't show the scrollbar
        ;; Save the frame size and position when exiting, and load'em on boot.
        (add-hook 'after-init-hook '(lambda ()
            "Load last frame geometry from a a file."
            (let
                (
                    (framegeometry-file (expand-file-name "_framegeometry" user-emacs-directory))
                )
                (when (file-readable-p framegeometry-file) (load-file framegeometry-file))
            )
        ))
        (add-hook 'kill-emacs-hook '(lambda ()
            "Save current frame geometry to a file."
            (let
                (
                    (framegeometry-left (frame-parameter (selected-frame) 'left))
                    (framegeometry-top (frame-parameter (selected-frame) 'top))
                    (framegeometry-width (frame-parameter (selected-frame) 'width))
                    (framegeometry-height (frame-parameter (selected-frame) 'height))
                    (framegeometry-file (expand-file-name "_framegeometry" user-emacs-directory))
                )
                (when (not (number-or-marker-p framegeometry-left)) (setq framegeometry-left 0))
                (when (not (number-or-marker-p framegeometry-top)) (setq framegeometry-top 0))
                (when (not (number-or-marker-p framegeometry-width)) (setq framegeometry-width 0))
                (when (not (number-or-marker-p framegeometry-height)) (setq framegeometry-height 0))
                (with-temp-buffer
                    (insert
                        "(setq initial-frame-alist '(\n"
                        (format "    (top . %d)\n" (max framegeometry-top 0))
                        (format "    (left . %d)\n" (max framegeometry-left 0))
                        (format "    (width . %d)\n" (max framegeometry-width 0))
                        (format "    (height . %d)\n" (max framegeometry-height 0))
                        "))\n"
                    )
                    (when (file-writable-p framegeometry-file) (write-file framegeometry-file))
                )
            )
        ))
    )
)

(provide 'native-frame)
