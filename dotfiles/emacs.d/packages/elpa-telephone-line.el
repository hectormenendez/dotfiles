;; A Powerline replacement.
(use-package telephone-line
    :ensure t
    :config (progn
        (require 'telephone-line-utils)

        (telephone-line-defsegment* telephone-line-project-segment () (telephone-line-raw
            (concat persp-last-persp-name ":" (projectile-project-name) "  ")
        ))

        (setq
            telephone-line-height 20
            telephone-line-evil-use-short-tag t
            ;; Left separators
            telephone-line-primary-left-separator 'telephone-line-identity-left
            telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left
            ;; Right separators
            telephone-line-primary-right-separator 'telephone-line-identity-left
            telephone-line-secondary-right-separator 'telephone-line-identity-hollow-left
            ;; The left segments
            telephone-line-lhs '(
                (evil . (telephone-line-evil-tag-segment)); Evil-mode status
                (accent . (telephone-line-vc-segment)); Version control status
                (nil . (telephone-line-buffer-segment)); Buffer info
            )
            ;; The right segments
            telephone-line-rhs '(
                (nil . (
                    telephone-line-airline-position-segment
                    telephone-line-major-mode-segment
                ))
                (accent . (telephone-line-minor-mode-segment))
                (evil . (telephone-line-project-segment))
            )
        )
        (telephone-line-mode 1)
    )
)

(provide 'elpa-telephone-line)
