;; Enable better handling of xml files (not need of ensuring, it's already included)
(use-package nxml-mode
    :defer t
    :mode (
        ("\\.plist\\'" . nxml-mode)
        ("\\.svg\\'" . nxml-mode)
        ("\\.xml\\'" . nxml-mode)
        ("\\.xslt\\'" . nxml-mode)
    )
    :config (progn
        (setq
            magic-mode-alist (cons '("<\\?xml " . nxml-mode) magic-mode-alist)
            nxml-slash-auto-complete-flag t
            nxml-auto-insert-xml-declaration-flag t
            nxml-child-indent 4
        )
        (fset 'xml-mode 'nxml-mode)
        (add-hook 'nxml-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
    )
)

(provide 'elpa-nxml-mode)
