;; ------------------------------------------------------------------ Repositories
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; Enable the 'use-package' package manager (install it if not available)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
)
(eval-when-compile (require 'use-package))

;;
(setq custom-file (expand-file-name "_custom.el" user-emacs-directory))

;; ----------------------------------------------------- Config: File management

;; Set backup files to a directory instead of a file on the same dir.
(setq backup-directory-alist '(("." . "~/.emacs.d/_backups")))

;; Make backup of everthing (disabled by default)
(setq make-backup-files nil)
(setq delete-old-versions t)
(setq version-control t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/_auto-save/" t)))

;; History
(setq savehist-file "~/.emacs.d/_history")
(setq savehist-save-minibuffer-history 1)
(setq history-length t)
(setq history-delete-duplicates t)
(savehist-mode 1)

;; Save the cursor position for every file.
(setq save-place-file "~/.emacs.d/_saveplace")
(setq save-place t)
(require 'saveplace)

(require 'diminish) ; TODO: Findout what this does.
(require 'bind-key) ; TODO: Findout what this does.

;;------------------------------------------------------------- Config: Look & Feel


(setq frame-title-format "emacs")
(setq inhibit-startup-screen 1)
(setq initial-scratch-message nil) ; Don't show a message on *scratch* mode
(setq whitespace-style '(face trailing)) ; Show an arrow whenever text is too long

;; (setq-default indent-tabs-mode nil) ; Always use spaces for indentation
(setq-default tab-width 4) ; Yeah, you read it right, 4! as in 1, 2, 3, 4.
(setq-default fill-column 90) ; The number of chars before wrapping (used by fci)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1) ; Show the current-column too
(global-hl-line-mode 1); Highlight the current line

(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-11"))

;; TODO: Add the gruvbox colors to this theme (use darktooth-theme as reference too)
;; TODO: Add theming for helm bar.
(add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/")
(load-theme 'birds-of-paradise-plus 1)

;; ------------------------------------------------------------------ Packages

;; VI rocks! there, I said it.
(use-package evil
    :ensure t
    :config
    ;; TODO: Improve wn this for the love of god.
    (setq evil-emacs-state-cursor '("red" box))
    (setq evil-normal-state-cursor '("black" box))
    (setq evil-visual-state-cursor '("orange" box))
    (setq evil-insert-state-cursor '("cyan" bar))
    (setq evil-replace-state-cursor '("blue" bar))
    (setq evil-operator-state-cursor '("red" hollow))
    (evil-mode 1)
    ;; Enable tpope's vim-commentary port
    (use-package evil-commentary
        :ensure t
        :config
        (add-hook 'prog-mode-hook 'evil-commentary-mode)
    )
    ;; Enable tpope's vim-surround port (globally)
    (use-package evil-surround
        :ensure t
        :config
        (global-evil-surround-mode 1)
    )
)

;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :diminish helm-mode ; TODO
    :commands helm-mode ; TODO
    :config
    (progn
        (require 'helm-config)
        (setq helm-buffers-fuzzy-matching t)
        (setq helm-autoresize-mode t)
        (setq helm-buffer-max-length 50)
        (setq helm-candidate-number-limit 100)
        ;; Try to update faster when hitting RET too quickly
        (setq
            helm-idle-delay 0.0
            helm-input-idle-delay 0.0
            helm-yas-display-key-on-candidate t
            helm-quick-update t
            helm-M-x-requires-pattern nil
            helm-ff-skip-boring-files t)
        (helm-mode 1)
	(ido-mode -1); Disable the "I Do" mode, we have helm for that now.
    )
    :bind (
        ("C-c C-c" . helm-mini)
        ("C-h C-h" . helm-apropos)
        ("C-c c b" . helm-buffers-list)
        ("M-x" . helm-M-x)
    )
)

;; Relative line-numbers
(use-package linum-relative
    :ensure t
    :config
    (setq linum-relative-current-symbol ""); Show the curren line-number
    (setq linum-relative-format "%3s "); Add some spaces to numbers
    (linum-relative-on)
    (add-hook 'prog-mode-hook 'linum-mode)
)

;; Indentation lines!
(use-package highlight-indent-guides
    :ensure t
    :config
    (setq highlight-indent-guides-method 'character)
    (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
)

;; Add an indicator at the fill-column position.
(use-package fill-column-indicator
    :ensure t
    :config
    (setq fci-rule-width 1)
    (setq fci-rule-color "#554040")
    (add-hook 'prog-mode-hook 'fci-mode)
)

;; Log working time on wakatime.com
;; TODO:  install wakatime-cli via pip and see if  it works.
;; (use-package wakatime-mode
;;     :ensure t
;;     :config
;;     (global-wakatime-mode)
;; )

  

(use-package rjsx-mode
    :ensure t
    :config
    (with-eval-after-load 'rjsx)
    (define-key rjsx-mode-map "<" nil)
)

