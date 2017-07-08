;p-*-Emacs-Lisp-*-

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
(setq custom-safe-themes t); Don't ask for confirmation when loading themes

;; Charset has to be unicode, like, always
(set-charset-priority 'unicode)
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(column-number-mode 1); Show the current-column too
(global-hl-line-mode 1); Highlight the current line
(global-auto-revert-mode 1); Update buffers whenever the file changes on disk
(global-prettify-symbols-mode 1); Convert lambda to λ
(show-paren-mode 1); Show matching parenthesis

; Whitespace management
(setq-default
   fill-column 90
   indent-tabs-mode nil; Use spaces for tabs
   require-final-newline nil; Don't end files with newline
   tab-always-indent t; The tab key will always indent (duh)
   tab-width 4; Use 4 spaces as indentation
   whitespace-style '(face tabs tab-mark trailing lines-tail); Highlight these
   whitespace-line-column fill-column; Use the fill-column to mark overflowed character
   whitespace-display-mappings '(; Customize the look of these character
       (tab-mark ?\t [?› ?\t])
       (newline-mark 10  [36 10])
   )
)
(global-whitespace-mode t)
(electric-indent-mode -1); don't auto-indent on the fly

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
(require 'savehist)
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
(require 'saveplace)
(setq save-place-file "~/.emacs.d/_saveplace")
(save-place-mode 1)

;; Themes location
(add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/")

;; Save all customisations to this file instead.
;; TODO: Find out why is not being read by emacs.
(setq custom-file "~/.emacs.d/_custom.el")
(load custom-file)

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
    ;; Show actual colors on color names
    (use-package rainbow-mode :ensure t)
))

;; ---------------------------------------------------------------------------- MacOS only

;; Make sure Mac's $PATH is available to emacs
(use-package exec-path-from-shell
    :if (memq window-system '(mac ns))
    :ensure t
    :init (setenv "SHELL" "/usr/local/bin/bash")
    :config (progn
        (setq exec-path-from-shell-check-startup-files nil); remove warning
        (setq exec-path-from-shell-variables '("PATH" "MANPATH"))
        (exec-path-from-shell-initialize)
    )
)

;; ------------------------------------------------------------------------------ Packages

;; Some packages use this, just in case, make it available
(use-package s :ensure t)

;; Try packages before installing.
(use-package try :ensure t)

;; Adds a command for restarting emacs
(use-package restart-emacs :ensure t)

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

;; Wait what? numbers don't get a highlight on emacs? fix it.
(use-package highlight-numbers
    :ensure t
    :diminish highlight-numbers-mode
    :config (add-hook 'prog-mode-hook 'highlight-numbers-mode)
)

;; What? no highlighted quotes for lisp either? c'mon man!
(use-package highlight-quoted
    :ensure t
    :diminish highlight-quoted-mode
    :config (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
)

;; ;; TODO: Add the gruvbox colors to this theme (use darktooth-theme as reference too)
;; ;; TODO: Add theming for helm bar.
;; (use-package birds-of-paradise-plus-theme :ensure t)
;; (use-package gruvbox-theme :ensure t)
(load-theme 'etor)

;; VI rocks! there, I said it.
(use-package evil
    :ensure t
    :config (progn
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
                (evil-leader/set-key "?" 'what-cursor-position)
                (global-evil-leader-mode)
            )
        )
        ;; Enable multiple-cursors
        (use-package evil-mc
            :ensure t
            :diminish evil-mc-mode
            :config (progn
                (global-evil-mc-mode 1)
            )
        )
        ;;Use evil on dired mode
        (eval-after-load 'dired '(progn
            (evil-make-overriding-map dired-mode-map 'normal t); the standard bindings
            (evil-define-key 'normal dired-mode-map
                "h" 'evil-backward-char
                "j" 'evil-next-line
                "k" 'evil-previous-line
                "l" 'evil-forward-char
                "w" 'evil-forward-word-begin
                "b" 'evil-backward-word-begin
            )
        ))
    )
)

;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :diminish helm-mode
    :init (progn
        ;; For some reason, if these are set on :config, they won't work.
        (evil-leader/set-key "SPC" 'helm-M-x)
        (evil-leader/set-key "TAB" 'helm-mini)
    )
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
        ; Disable the "I Do" mode, we have helm for that now.
        (ido-mode -1)
        (helm-mode 1)
    )
    :bind (
        ("C-c C-c" . helm-mini); Find all
        ("C-h C-h" . helm-apropos); Find help
        ("C-c C-b" . helm-buffers-list)
        ("M-x" . helm-M-x)
        ("M-y" . helm-show-kill-ring)
        ("C-s" . helm-occur); Find ocurrences of pattern
    )
)

;; Workspace management via perspectives
(use-package persp-mode
    :ensure t
    :config (progn
        (setq
            persp-autokill-buffer-on-remove 'kill-weak; kill the buffer when closed
            persp-nil-name "main"; The name of the default perspective
            persp-save-dir "~/.emacs.d/_perspectives/"
            persp-auto-save-fname "autosave"
            persp-set-last-persp-for-new-frames nil; don't use last persp for new frames
            persp-auto-save-opt 1; Auto-save perspective on buffer kill
            persp-auto-resume-time 1; Load perspectives on startup
        )
        ;; Integrate with projectile
        (use-package persp-mode-projectile-bridge
            :ensure t
            :config (add-hook 'persp-mode-projectile-mode-hook '(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                    (persp-mode-projectile-bridge-kill-perspectives)
                )
            ))
        )
        (add-hook 'after-init-hook '(lambda ()
            (persp-mode 1)
            (persp-mode-projectile-bridge-mode 1)
        ))
    )
)

;; Quick switching files
(use-package projectile
    :ensure t
    :config (progn
        (use-package helm-projectile
            :ensure t
            :commands helm-projectile-on
            :bind (
                ("C-c C-f" . helm-projectile-find-file)
                ("C-c C-d" . helm-projectile-find-dir)
            )
        )
    )
)

;; Enable version control using Magit (fugitive alternative)
(use-package magit
    :ensure t
    :config (progn
        (evil-leader/set-key "gs" 'magit-status)
        (evil-leader/set-key "gc" 'magit-commit)
        (evil-leader/set-key "gp" 'magit-push)
        (evil-leader/set-key "gd" 'vc-diff)
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
        ;; Enable company in any programming mode
        (add-hook 'prog-mode-hook 'company-mode)
        ;; Enable tern
        (use-package tern
            :ensure t
            :config (progn
                (add-hook 'js2-mode-hook 'tern-mode)
                (setq tern-command (append tern-command '("--no-port-file")))
            )
        )
        (use-package company-tern
            :ensure t
            :init (add-to-list 'company-backends 'company-tern)
            :config (setq company-tern-property-marker nil)
        )
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
        (setq linum-relative-format " %3s"); Add some spaces to numbers
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
        (setq highlight-indent-guides-auto-enabled nil); don't calculate color
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
        (setq git-gutter:update-interval 2); Update git gutter after n secs idle
        (setq git-gutter:ask-p nil); Don't ask confirmation when committing or reverting
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
        ;; Allow to use evil mode with neotree
        (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
        (evil-define-key 'normal neotree-mode-map (kbd "<f5>") 'neotree-refresh)
        (evil-define-key 'normal neotree-mode-map (kbd "<escape>") 'neotree-toggle)
        (evil-define-key 'normal neotree-mode-map (kbd "m") 'neotree-rename-node)
        (evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
        ;; (evil-define-ket 'normal neotree-mode-map (kbd "|") 'neotree-)
        (setq neo-smart-open t); let neotree find the current file and jump to it.
        ;; work along with projectile
        (setq projectile-switch-project-action 'neotree-projectile-action)
        ;; show hidden files by default
        (setq-default neo-show-hidden-files t)
        ;; Enable theme
        (use-package all-the-icons
            :ensure t
            :config (setq neo-theme (
                (if (display-graphic-p) 'icons 'arrow)
            ))
        )
        ;; Use ffip to determine the project root and open neotree relative to it.
        (use-package find-file-in-project
            :ensure t
            :config (evil-leader/set-key "RET" (lambda ()
                (interactive)
                (let
                    (
                        (project-dir (ffip-project-root))
                        (file-name (buffer-file-name))
                    )
                    (if project-dir
                        (progn
                            (neotree-dir project-dir)
                            (neotree-find file-name)
                        )
                        (message "Could not find git project root.")
                    )
                )
            ))
        )
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
        ;; Split windows showing the scratch buffer instead of the same file
        (evil-leader/set-key "w|" '(lambda ()
            (interactive)
            (split-window-horizontally)
            (balance-windows)
            (other-window 1 nil)
            (switch-to-buffer "*scratch*")
        ))
        (evil-leader/set-key "w-" (lambda ()
            (interactive)
            (split-window-vertically)
            (balance-windows)
            (other-window 1 nil)
            (switch-to-buffer "*scratch*")
        ))
        ;; Key bindings for evil-mode
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
    :commands global-hl-todo-mode
    :bind (
        ("C-c t n" . hl-todo-next)
        ("C-c t p" . hl-todo-previous)
        ("C-c C-t" . hl-todo-occur)
    )
)

;; Mame NVM available
(use-package nvm
    :if (file-exists-p "~/.nvm")
    :ensure t
    :config (nvm-use (caar (last (nvm--installed-versions))))
)

;; Syntax checking
(use-package flycheck
    :ensure t
    :init (setq-default flycheck-disabled-checkers (append '(
        javascript-jshint
        javascript-jscs
        javascript-standard
    )))
    :config (progn
        (setq flycheck-temp-prefix ".flycheck")
        (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
        (flycheck-add-mode 'javascript-eslint 'js2-mode)
        (add-hook 'prog-mode-hook 'global-flycheck-mode)
    )
)

;; Enable Javascript mode
(use-package json-mode :ensure t)
(use-package js2-mode
    :ensure t
    :defer t
    :commands js2-mode
    :mode (
        ("\\.js\\'" . js2-mode)
        ("\\.json\\'" . json-mode)
    )
    :config (progn
        (setq-default
            js2-basic-offset 4
            js2-auto-indent-p t
            js2-indent-switch-body t
            js2-indent-on-enter-key t
        )
        (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
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

(provide 'emacs)
;;; emacs ends here
