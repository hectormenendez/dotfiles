; ----------------------------------------------------------------------------- Behaviour

;; Disable the default packaage-manager at startup
(require 'package)
(setq package-enable-at-startup nil)

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; This will be added no matter what, so, add it.
(package-initialize)

;; Enable the 'use-package' package manager (install it if not available)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
)
(eval-when-compile (require 'use-package))

;; Save all customisations to this file instead.
;; TODO: Find out why is not being read by emacs.
(setq custom-file (expand-file-name "_custom.el" user-emacs-directory))

;; Enable the server so several clients can connect to it.
(require 'server)
(unless (server-running-p) (server-start))

;; -------------------------------------------------------------------------------- Editor

(setq frame-title-format "emacs")
(setq inhibit-startup-screen 1)
(setq initial-scratch-message nil); Don't show a message on *scratch* mode
(setq visible-bell t); don't make sounds, show bells.

; be immediate about scrolling
(setq mouse-wheel-progressive-speed nil)
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

; Higlight invalid whitespaces
(require 'whitespace)
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1); Show the current-column too
(global-hl-line-mode 1); Highlight the current line
(global-auto-revert-mode); Update buffers whenever the file changes on disk
(defalias 'yes-or-no-p 'y-or-n-p); Ask for just one letter

;; ------------------------------------------------------------------------- Window System

(add-to-list 'default-frame-alist '(font . "Ubuntu Mono")); The default font
(add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/"); The default theme location

;; Save and restore the window geometry.
;; TODO: This should be on its own file.
(if window-system (progn
    ;; Save current geometry to a file.
    (defun framegeometry-save () (let
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
    ))
    ;; Load geometry from file
    (defun framegeometry-load () (let
        (
            (framegeometry-file (expand-file-name "_framegeometry" user-emacs-directory))
        )
        (when (file-readable-p framegeometry-file) (load-file framegeometry-file))
    ))
    ;; Enable hooks.
    (add-hook 'after-init-hook 'framegeometry-load)
    (add-hook 'kill-emacs-hook 'framegeometry-save)
))

;; -------------------------------------------------------------------------------- DarwiN

(if window-system (progn
    (setq mac-right-option-modifier 'none); Right Alt should not be Meta
    (global-set-key (kbd "s-+") 'text-scale-increase)
    (global-set-key (kbd "s--") 'text-scale-decrease)
))

;; ------------------------------------------------------------------------------ Defaults

(setq-default indent-tabs-mode nil); Use spaces for tabs
(setq-default tab-width 4); set tab width to 4 on every mode
(setq-default fill-column 90); The number of chars before wrapping (used by fci)
(show-paren-mode 1)

;; ----------------------------------------------------------------------- Version Control

(setq version-control t)
(setq vc-follow-symlinks t); Don't ask to follow symlinks, just do it.

;; ----------------------------------------------------------------------- File management

;; Backing up
(setq make-backup-files t)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/_backups")))

;; Auto saving (disabled)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/_auto-save/" t)))
(setq auto-save-default nil)

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

(require 'diminish); TODO: Findout what this does.
(require 'bind-key); TODO: Findout what this does.

;; ------------------------------------------------------------------------------ Packages


;; Try packages before installing.
(use-package try
    :ensure t
)

(use-package which-key
    :ensure t
    :config (which-key-mode)
)

;; TODO: Add the gruvbox colors to this theme (use darktooth-theme as reference too)
;; TODO: Add theming for helm bar.
(use-package birds-of-paradise-plus-theme
    :ensure t
)

;; VI rocks! there, I said it.
(use-package evil
    :ensure t
    :config (progn
        ;; Setup the colors for the cursor on different modes.
        ;; TODO: Improve these colors.
        (setq
            evil-emacs-state-cursor '("red" box)
            evil-normal-state-cursor '("black" box)
            evil-visual-state-cursor '("orange" box)
            evil-insert-state-cursor '("cyan" bar)
            evil-replace-state-cursor '("blue" bar)
            evil-operator-state-cursor '("red" hollow)
        )
        ;; Enable evil-mode baby!
        (evil-mode 1)
        ;; Enable tpope's vim-commentary port
        (use-package evil-commentary
            :ensure t
            :config (add-hook 'prog-mode-hook 'evil-commentary-mode)
        )
        ;; Enable tpope's vim-surround port (globally)
        (use-package evil-surround
            :ensure t
            :config (global-evil-surround-mode 1)
        )
    )
)

;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :diminish helm-mode ; TODO
    :commands helm-mode ; TODO
    :config (progn
        (require 'helm-config)
        ;; Enable fuzzy matching
        (setq
            helm-candidate-number-limit 100
            helm-mode-fuzzy-match t
            helm-completion-in-region-fuzzy-match t
        )
        (setq helm-autoresize-mode t)
        (setq helm-buffer-max-length 50)
        ;; Try to update faster when hitting RET too quickly
        (setq
            helm-idle-delay 0.0
            helm-input-idle-delay 0.0
            helm-yas-display-key-on-candidate t
            helm-quick-update t
            helm-M-x-requires-pattern nil
            helm-ff-skip-boring-files t
        )
        (ido-mode -1); Disable the "I Do" mode, we have helm for that now.
        (helm-mode 1)
    )
    :bind (
        ("C-c C-c" . helm-mini)
        ("C-h C-h" . helm-apropos)
        ("C-c c b" . helm-buffers-list)
        ("M-x" . helm-M-x)
        ("M-y" . helm-show-kill-ring)
    )
)

;; Enable version control using Magit (fugitive alternative)
(use-package magit
    :ensure t
    :bind (
        ("C-c g s" . magit-status)
    )
)

;; Relative line-numbers
(use-package linum-relative
    :ensure t
    :config (progn
        (setq linum-relative-current-symbol ""); Show the current line-number
        (setq linum-relative-format "%3s "); Add some spaces to numbers
        (linum-relative-on)
        (add-hook 'prog-mode-hook 'linum-mode)
    )
)

;; Indentation lines!
(use-package highlight-indent-guides
    :ensure t
    :config (progn
        (setq highlight-indent-guides-method 'character)
        (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    )
)

;; Add an indicator at the fill-column position.
(use-package fill-column-indicator
    :ensure t
    :config (progn
        (setq fci-rule-width 1)
        (setq fci-rule-color "#554040")
        (add-hook 'prog-mode-hook 'fci-mode)
    )
)

;; Smart pairs
(use-package smartparens
    :ensure t
    :config (progn
        (require 'smartparens-config)
        (add-hook 'prog-mode-hook 'smartparens-mode)
    )
)

;; Enable JSX syntax support
(use-package rjsx-mode
    :ensure t
    :config (progn
        (with-eval-after-load 'rjsx)
        (define-key rjsx-mode-map "<" nil); This behaviour made emacs hang, so disabled it.
    )
)

;; Adds a gutter with the git status of each file (duh)
(use-package git-gutter
    :ensure t
    :config (progn
        (git-gutter:linum-setup)
        (custom-set-variables
            '(git-gutter:update-interval 2)
            '(git-gutter:modified-sign " ~")
            '(git-gutter:added-sign " +")
            '(git-gutter:deleted-sign " -")
        )
        (set-face-foreground 'git-gutter:modified "#54969a"); gruvbox's blue
        (set-face-foreground 'git-gutter:added "#a8a521"); grubox's green
        (set-face-foreground 'git-gutter:deleted "#d83925"); gruvbox's red
        (add-hook 'prog-mode-hook 'git-gutter-mode)
    )
)

;; Keeps current line always vertically centered to the screen
(use-package centered-cursor-mode
    :ensure t
    :config (add-hook 'prog-mode-hook 'centered-cursor-mode)
)

;; Allows easier movement from window to window
(use-package ace-window
    :ensure t
    :config (progn
        (global-set-key [remap other-window] 'ace-window)
        ;; Set the font-face for the ace-window indicator
        (custom-set-faces
            '(aw-leading-char-face ((t (
                :inherit ace-jump-face-foreground
                :foreground "#FFFFFF"
                :height 3.0))
            ))
        )
    )
)

;; Log working time on wakatime.com
;; TODO:  install wakatime-cli via pip and see if  it works.
;; (use-package wakatime-mode
;;     :ensure t
;;     :config
;;     (global-wakatime-mode)
;; )
