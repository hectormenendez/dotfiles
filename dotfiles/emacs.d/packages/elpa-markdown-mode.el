(use-package markdown-mode
    :ensure t
    :mode (
        ("README\\.md\\'" . gfm-mode); Use github flavored markdown
        ("\\.md\\'" . markdown-mode)
        ("\\.markdown\\'" . markdown-mode)
    )
)

(provide 'elpa-markdown-mode)
