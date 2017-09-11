;;; init.el --- Personal emac configuration of Héctor Menéndez

;;; Commentary:
;;; Hey, don't judge, this is a work in progresss, damn it!

;;; Code:

;; ---------------------------------------------------------------------- Helper constants


(defconst *path-elpa* (expand-file-name "_elpa" user-emacs-directory))
(defconst *path-packages* (expand-file-name "packages" user-emacs-directory))

;; ----------------------------------------------------------------------- Core settings

(setq
    ;; Core
    visible-bell t; don't make sounds, show bells.
    message-log-max 10000
    load-prefer-newer t; Don't load outdated byte code
    gc-cons-threshold 2000000; no need of garbage collect that often
    max-mini-window-height 0.5; Use up to 50% of frame height for mini-buffer window.
    ;; Startup
    inhibit-startup-screen 1; Don't show the welcome screen
    initial-scratch-message nil; Don't show a message on *scratch* mode
)

; Ask for just one letter when confirmation needed
(defalias 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------------------------------------- Package Manager

(require 'package)

(setq
    package-enable-at-startup nil; Disable the default packaage-manager at startup
    package-user-dir *path-elpa*; packages dir
)

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; The local packages
(add-to-list 'load-path *path-packages*)

;; This will be added no matter what, so, add it.
(package-initialize)

;; Enable the 'use-package' package manager (install it if not available)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
)
(eval-when-compile (require 'use-package))

(use-package bind-key :demand t); Allows the  use of :bind
(use-package delight :ensure t); Diminish alternative, allows to rename mode names

;; ---------------------------------------------------------------------- Packages: Native

(require 'native-simple)
(require 'native-server)
(require 'native-files)
(require 'native-recentf)
(require 'native-savehist)
(require 'native-saveplace)
(require 'native-autorevert)
(require 'native-custom)
(require 'native-mule)
(require 'native-whitespace)
(require 'native-electric)
(require 'native-paren)
(require 'native-prog-mode)
(require 'native-frame)

;; ------------------------------------------------------------------------- ELPA Packages

; (require 'elpa-centered-cursor-mode)
(require 'elpa-exec-path-from-shell)
(require 'elpa-try)
(require 'elpa-restart-emacs)
(require 'elpa-help+)
(require 'elpa-zoom-frm)
(require 'elpa-rainbow-mode)
(require 'elpa-smartparens)
(require 'elpa-rainbow-delimiters)
(require 'elpa-dired+)
(require 'elpa-highlight-indent-guides)
(require 'elpa-highlight-numbers)
(require 'elpa-highlight-quoted)
(require 'elpa-hl-todo)
(require 'elpa-pretty-lambdada)
(require 'elpa-which-key)
(require 'elpa-evil)
(require 'elpa-expand-region)
(require 'elpa-multiple-cursors)
(require 'elpa-helm)
(require 'elpa-persp-mode)
(require 'elpa-projectile)
(require 'elpa-magit)
(require 'elpa-company)
(require 'elpa-undo-tree)
(require 'elpa-linum-relative)
(require 'elpa-git-gutter)
(require 'elpa-fill-column-indicator)
(require 'elpa-dtrt-indent)
(require 'elpa-neotree)
(require 'elpa-ace-window)
(require 'elpa-telephone-line)
(require 'elpa-nvm)
(require 'elpa-dumb-jump)
(require 'elpa-json-mode)
(require 'elpa-js2-mode)
(require 'elpa-rjsx-mode)
(require 'elpa-flycheck)
(require 'elpa-markdown-mode)
(require 'elpa-nxml-mode)
(require 'elpa-wakatime-mode)

(provide 'emacs)
;;; emacs ends here
