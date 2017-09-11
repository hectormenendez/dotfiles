;; Make NVM available
(use-package nvm
    :if (file-exists-p "~/.nvm")
    :ensure t
    :config (nvm-use (caar (last (nvm--installed-versions))))
)

(provide 'elpa-nvm)
