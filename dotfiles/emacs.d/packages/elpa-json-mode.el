;; Enable Json mode
(use-package json-mode
    :ensure t
    :commands json-mode
    :mode ("\\.json\\'" . json-mode)
)

(provide 'elpa-json-mode)
