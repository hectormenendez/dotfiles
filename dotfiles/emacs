;-*-Emacs-Lisp-*-

; ------------------------------------------------------------------------ Package Manager

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
(require 'diminish); for :diminish
(require 'bind-key); for :bind

;; -------------------------------------------------------------------------------- Server

(require 'server)
(unless (server-running-p) (server-start))

;; -------------------------------------------------------------------------------- Editor

(setq inhibit-startup-screen 1)
(setq initial-scratch-message nil); Don't show a message on *scratch* mode
(setq visible-bell t); don't make sounds, show bells.
(setq default-fill-column 90); determines where the lines should end. (used by fci)

(column-number-mode 1); Show the current-column too
(global-hl-line-mode 1); Highlight the current line
(global-auto-revert-mode 1); Update buffers whenever the file changes on disk
(global-prettify-symbols-mode 1); Convert lambda to λ
(show-paren-mode 1); Show matching parenthesis

; Whitespace management
(require 'whitespace)
(setq whitespace-style '(face empty tabs trailing))
(setq indent-tabs-mode nil); Use spaces for tabs
(setq tab-width 4); set tab width to 4 on every mode
(global-whitespace-mode t)

;; Version control
(setq version-control t)
(setq vc-follow-symlinks t); Don't ask to follow symlinks, just do it.

(defalias 'yes-or-no-p 'y-or-n-p); Ask for just one letter

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

;; Track opened files
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/_recentf")
(setq recentf-filename-handlers '(abbreviate-file-name))
(recentf-mode 1)

;; Save the cursor position for every file.
(setq save-place-file "~/.emacs.d/_saveplace")
(save-place-mode 1)

;; Themes location
(add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/")

;; Save all customisations to this file instead.
;; TODO: Find out why is not being read by emacs.
(setq custom-file (expand-file-name "_custom.el" user-emacs-directory))

;; ------------------------------------------------------------------------------ GUI only

;; Save and restore the frame geometry.
;; TODO: This should be on its own file.
(if window-system (progn
    ;; Allow the frame to become full-screen with the usual key-binding
    (global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)
    ;; Frame appareance
    (setq frame-title-format "emacs")
    (tool-bar-mode -1); Don't show the toolbar
    (scroll-bar-mode -1); Don't show the scrollbar
    ;; Font appareance
    (add-to-list 'default-frame-alist '(font . "Ubuntu Mono")); The default font

    ; (setq mac-right-option-modifier 'none); Right Alt should not be Meta

    ;; Save the frame size and position when exiting, and load'em on boot.
    ;; TODO: This should be a plugin.
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
    (defun framegeometry-load () (let
        (
            (framegeometry-file (expand-file-name "_framegeometry" user-emacs-directory))
        )
        (when (file-readable-p framegeometry-file) (load-file framegeometry-file))
    ))
    (add-hook 'after-init-hook 'framegeometry-load)
    (add-hook 'kill-emacs-hook 'framegeometry-save)
    ;; Use common key-bindings for zooming the frame.
    (use-package zoom-frm
        :ensure t
	:config (progn
	    ;; TODO: this doesn't do anything apparently.
	    (setq zoom-frame/buffer 'buffer)
	    ;; Disable default text-scaling (it messes up with FCI)
            (global-set-key (kbd "C-x C-0") nil)
            (global-set-key (kbd "C-x C-=") nil)
            (global-set-key (kbd "C-x C-+") nil)
            (global-set-key (kbd "C-x C--") nil)
            ;; Now setup the bindings with the zoom plugin
            (global-set-key (kbd "M-0") 'zoom-frm-unzoom)
            (global-set-key (kbd "M-+") 'zoom-frm-in)
            (global-set-key (kbd "M--") 'zoom-frm-out)
	)
    )

))

;; ---------------------------------------------------------------------------- MacOS only

;; Make sure Mac's $PATH is available to emacs
(use-package exec-path-from-shell
    :if (memq window-system '(mac ns))
    :ensure t
    :config (exec-path-from-shell-initialize)
)

;; ------------------------------------------------------------------------------ Packages

;; Some packages use this, just in case, make it available
(use-package s :ensure t)

;; Try packages before installing.
(use-package try :ensure t)

;; Hide minor modes from line-mode (used by 'use-package')
(use-package diminish
    :ensure t
    :config (progn
        (diminish 'global-whitespace-mode)
        (diminish 'auto-revert-mode)
    )
)

;; Show all available mas when key is pressed. (after a timeout)
(use-package which-key
    :ensure t
    :diminish which-key-mode
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
        ;; Have <tab> to work as it does on Vim
        (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
        ;; Enable evil-mode baby!
        (evil-mode 1)
        ;; Enable tpope's vim-commentary port
        (use-package evil-commentary
            :ensure t
	    :diminish evil-commentary-mode
            :config (add-hook 'prog-mode-hook 'evil-commentary-mode)
        )
        ;; Enable tpope's vim-surround port (globally)
        (use-package evil-surround
            :ensure t
	    :diminish evil-surround-mode
            :config (global-evil-surround-mode 1)
        )
        ;; Enable the <leader> key like in Vim
        (use-package evil-leader
            :ensure t
            :config (progn
                (evil-leader/set-leader "SPC")
                (global-evil-leader-mode)
            )
        )
    )
)

;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :diminish helm-mode
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
        (evil-leader/set-key "SPC" 'helm-M-x)
        (evil-leader/set-key "TAB" 'helm-mini)
        ; Disable the "I Do" mode, we have helm for that now.
        (ido-mode -1)
        (helm-mode 1)
    )
    :bind (
        ("C-c C-c" . helm-mini); Find all
        ("C-h C-h" . helm-apropos); Find help
        ("C-c C-b" . helm-buffers-list)
	("C-c C-f" . helm-find-files)
	("C-c f" . helm-find)
        ("M-x" . helm-M-x)
        ("M-y" . helm-show-kill-ring)
        ("C-s" . helm-occur); Find ocurrences of pattern
    )
)

;; Enable version control using Magit (fugitive alternative)
(use-package magit
    :ensure t
    :config (progn
        (evil-leader/set-key "gs" 'magit-status)
        (evil-leader/set-key "gc" 'magit-commit)
        (evil-leader/set-key "gp" 'magit-push)
        (evil-leader/set-key "g+" 'git-gutter:stage-hunk)
        (evil-leader/set-key "g-" 'git-gutter:revert-hunk)
        (evil-leader/set-key "g}" 'git-gutter:next-hunk)
        (evil-leader/set-key "g{" 'git-gutter:previous-hunk)
    )
)

;; Autocompletion
(use-package company
    :ensure t
    :diminish company-mode
    :config (progn
        (add-hook 'prog-mode-hook 'company-mode)
    )
)

;; Generate a traversable undo history for files
(use-package undo-tree
    :ensure t
    :diminish undo-tree-mode
    :config (progn
        (setq undo-tree-auto-save-history t)
        (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/_undotree")))
	(global-undo-tree-mode 1)
    )
    :bind (
        ("C-x u" . undo-tree-visualize)
    )
)
;; Relative line-numbers
(use-package linum-relative
    :ensure t
    :diminish linum-relative-mode
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
    :diminish highlight-indent-guides-mode
    :config (progn
        (setq highlight-indent-guides-method 'character)
        (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    )
)

;; Try to guess the current file indentation and set emacs to follow it
(use-package dtrt-indent
    :ensure t
    :config (add-hook 'prog-mode-hook 'dtrt-indent-mode)
)

;; Add an indicator at the fill-column position.
(use-package fill-column-indicator
    :ensure t
    :diminish fci-mode
    :config (progn
        (setq fci-rule-width 1)
        (setq fci-rule-color "#554040")
        (add-hook 'prog-mode-hook 'fci-mode)
    )
)

;; Smart pairs
(use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config (progn
        (require 'smartparens-config)
        (add-hook 'prog-mode-hook 'smartparens-mode)
    )
)

;; Use different colors for parenthesis to ease matching
(use-package rainbow-delimiters
    :ensure t
    :config (progn
        (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    )
)

;; Adds a gutter with the git status of each file (duh)
;; TODO: the gutter doesn't update when loading files
(use-package git-gutter
    :ensure t
    :diminish git-gutter-mode
    :config (progn
        (git-gutter:linum-setup); play along with linum-mode
	;; Customize symbols and colors
        (set-face-foreground 'git-gutter:modified "#54969a"); gruvbox's blue
        (set-face-foreground 'git-gutter:added "#a8a521"); grubox's green
        (set-face-foreground 'git-gutter:deleted "#d83925"); gruvbox's red
	;; when to update
        (setq git-gutter:update-interval 2); Update git gutter after n secs idle
        (setq git-gutter:ask-p nil); Don't ask confirmation when committing or reverting
        (setq git-gutter:modified-sign " ~")
        (setq git-gutter:added-sign " +")
        (setq git-gutter:deleted-sign " -")
	(add-to-list 'git-gutter:update-hooks 'focus-in-hook)
        (add-to-list 'git-gutter:update-hooks 'magit-post-refresh-hook)
        (add-to-list 'git-gutter:update-hooks 'git-gutter:post-command-hook)
        (add-hook 'prog-mode-hook 'git-gutter-mode)
    )
)

;; Keeps current line always vertically centered to the screen
(use-package centered-cursor-mode
    :ensure t
    :diminish centered-cursor-mode
    :config (add-hook 'prog-mode-hook 'centered-cursor-mode)
)

;; Show a file-tree ala Vim
(use-package neotree
    :ensure t
    :config (progn
        (evil-leader/set-key "tn" 'neotree-toggle)
        ;; Allow to use evil mode with neotree
        (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
        (evil-define-key 'normal neotree-mode-map (kbd "-") 'neotree-enter-horizontal-split)
        (evil-define-key 'normal neotree-mode-map (kbd "|") 'neotree-enter-vertical-split)
        ;; (evil-define-ket 'normal neotree-mode-map (kbd "|") 'neotree-)
        (setq neo-smart-open t); let neotree find the current file and jump to it.
    )
)

;; Allows easier movement from window to window
(use-package ace-window
    :ensure t
    :diminish ace-window-mode
    :config (progn
        ;; Replace "other-window"
        (global-set-key [remap other-window] 'ace-window)
        ;; Disable the usual bindings for window management
        (global-set-key (kbd "C-x 0") nil); closes window
        (global-set-key (kbd "C-x 1") nil); delete other windows
        (global-set-key (kbd "C-x 2") nil); splits window horizontally
        (global-set-key (kbd "C-x 3") nil); splits window vertically
        ;; Key bindings for evil-mode (window management related)
        (evil-leader/set-key "|" 'split-window-horizontally)
        (evil-leader/set-key "-" 'split-window-vertically)
        (evil-leader/set-key "ww" 'ace-window)
        (evil-leader/set-key "wh" 'windmove-left)
        (evil-leader/set-key "wj" 'windmove-down)
        (evil-leader/set-key "wk" 'windmove-up)
        (evil-leader/set-key "wl" 'windmove-right)
        (evil-leader/set-key "wq" 'delete-window)
        (evil-leader/set-key "wo" 'delete-other-windows)
        (evil-leader/set-key "w=" 'balance-windows)
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

;; A Powerline replacement.
;; TODO: The colors for evil-mode look awful, replace this with smartline maybe?
(use-package telephone-line
    :ensure t
    :config (progn
        ;; The left segments
        (setq telephone-line-lhs '(
            (evil . (telephone-line-evil-tag-segment)); Evil-mode status
            (accent . (telephone-line-vc-segment)); Version control status
            (nil . (telephone-line-buffer-segment)); Buffer info
        ))
        ;; The right segments
        (setq telephone-line-rhs '(
            (nil . (
                telephone-line-misc-info-segment
                telephone-line-airline-position-segment
            ))
            (accent . (
                telephone-line-minor-mode-segment
                telephone-line-major-mode-segment
            ))
        ))
        (telephone-line-mode 1)
    )
)

;; Log working time on wakatime.com
(if (file-exists-p "/usr/local/bin/wakatime") (use-package wakatime-mode
    :ensure t
    :diminish wakatime-mode "w"
    :config (progn
	(setq
	    wakatime-cli-path "/usr/local/bin/wakatime"
	    wakatime-python-bin "/usr/local/bin/python"
	)
	(global-wakatime-mode 1)
    )
))

;; Highlight TODOs
;; TODO: Mode triggers until first calling
(use-package hl-todo
    :ensure t
    :config (global-hl-todo-mode t)
    :bind (
        ("C-c t n" . hl-todo-next)
	("C-c t p" . hl-todo-previous)
	("C-c C-t" . hl-todo-occur)
    )
)

;; Enable JSX syntax support
(use-package rjsx-mode
    :ensure t
    :config (progn
        (with-eval-after-load 'rjsx)
        (define-key rjsx-mode-map "<" nil); This behaviour made emacs hang, so disabled it
    )
)
