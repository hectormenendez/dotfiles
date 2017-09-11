;; Enable JSX syntax support
(use-package rjsx-mode
    :ensure t
    :config (add-hook 'rjsx-mode-hook (lambda ()
        (define-key rjsx-mode-map "<" nil); This behaviour made emacs hang, so disabled it
        (setq
            sgml-basic-offset tab-width; Indent tags like everything else
            sgml-attribute-offset 0; use the same spacing as the basic offset
        )
    ))
)

(provide 'elpa-rjsx-mode)
