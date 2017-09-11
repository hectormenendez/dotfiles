;; File handling
(use-package files
    :demand t
    :config (setq
        make-backup-files t
        delete-old-versions t
        version-control t; Keep control of backups
        vc-follow-symlinks t; Don't ask to follow symlinks, just do it.
        backup-directory-alist '(("." . "~/.emacs.d/_backups"))
        auto-save-file-name-transforms'((".*" "~/.emacs.d/_auto-save/" t));  where to save
        auto-save-default nil; Disable auto-saving
        require-final-newline nil; Don't end files with newline
    )
)

(provide 'native-files)
