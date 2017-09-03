;;; init.el --- Personal emac configuration of Héctor Menéndez

;;; Commentary:
;;  Personal Emacs configuration of Héctor Menéndez

;;; Code:

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

;; Disable the default packaage-manager at startup
(require 'package)
(setq package-enable-at-startup nil)

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

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

;; Basic editor configuration
(use-package simple
    :demand t
    :config (progn
        (column-number-mode 1); Show the current-column number
        (global-hl-line-mode 1); Highlight the current line
    )
)

;; Enable Emacs server so clients can connect to current session
(use-package server
    :demand t
    :config (add-hook 'after-init-hook '(lambda ()
        (unless (server-running-p) (server-start))
    ))
)

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

;; History
(use-package savehist
    :demand t
    :config (progn
        (setq
            savehist-file "~/.emacs.d/_history"
            savehist-save-minibuffer-history 1
            history-length t
            history-delete-duplicates t
        )
        (savehist-mode 1)
    )
)

;; Track opened files
(use-package recentf
    :demand t
    :config (progn
        (setq
            recentf-save-file "~/.emacs.d/_recentf"
            recentf-filename-handlers '(abbreviate-file-name)
        )
        (recentf-mode 1)
    )
)

;; Save the cursor position for every file.
(use-package saveplace
    :demand t
    :config (progn
        (setq save-place-file "~/.emacs.d/_saveplace")
        (save-place-mode 1)
    )
)

;; Auto update files when modified outside Emacs
(use-package autorevert
    ;; Update buffers whenever the file changes on disk
    :delight (auto-revert-mode)
    :config (progn
        (setq
            auto-revert-verbose nil
            global-auto-revert-non-file-buffers t; Enable autorevert on dired buffers
        )
        (global-auto-revert-mode 1)
    )
)

;; Customisations (mostly themes)
(use-package custom
    ;; TODO: validate the existence of the theme before trying to load it
    :demand t
    :config (progn
        (setq
            custom-safe-themes t; Don't ask for confirmations when loading themes
            custom-file "~/.emacs.d/_custom.el"; Save customisations to this file
        )
        (add-to-list 'custom-theme-load-path "~/.emacs.d/_themes/"); Themes location
        (load custom-file)
    )
)

;; Multilingual support (set everything to utf-8, basically)
(use-package mule
    :demand t
    :config (progn
        (setq
            locale-coding-system 'utf-8
            buffer-file-coding-system 'utf-8
        )
        (prefer-coding-system 'utf-8)
        (set-charset-priority 'unicode)
        (set-language-environment 'utf-8)
        (set-default-coding-systems 'utf-8)
        (set-terminal-coding-system 'utf-8)
        (set-keyboard-coding-system 'utf-8)
        (set-selection-coding-system 'utf-8)
    )
)

;; Show invalid whitespaces
(use-package whitespace
    :demand t
    :delight (global-whitespace-mode)
    :init (setq-default ;; These are core & indent vars
        fill-column 90
        tab-width 4; Use 4 spaces as indentation
        indent-tabs-mode nil; Use spaces for tabs
        tab-always-indent t; The tab key will always indent (duh)
        tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88)
    )
    :config (progn
        (setq-default
            whitespace-style '(face tabs tab-mark trailing lines-tail); Highlight these
            whitespace-line-column fill-column; Use the fill-column to mark overflowed
            whitespace-display-mappings '(; Customize the look of these character
                (tab-mark ?\t [?› ?\t])
                (newline-mark 10  [36 10])
            )
        )
        (global-whitespace-mode 1)
    )
)

;; Automate behaviour
(use-package electric
    ;; TODO: Find out more about this module so it actually does something.
    :demand t
    :config (progn
        (electric-indent-mode -1); when pressing return auto-indent will be disabled
    )
)

; Show matching parenthesis
(use-package paren :demand t :config (show-paren-mode 1))

;; Settings for programming modes
(use-package prog-mode
    :config (progn
        ;; Normally prettify-symbols makes a good work replacing symbols, sadly,
        ;; this breaks the ligature functionallity of fonts that have it (like Fira Code).
        (global-prettify-symbols-mode 0)
        ;; Setup ligatures
        (let
            ((alist '(
                (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                (36 . ".\\(?:>\\)")
                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                (48 . ".\\(?:x[a-zA-Z]\\)")
                (58 . ".\\(?:::\\|[:=]\\)")
                (59 . ".\\(?:;;\\|;\\)")
                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                (91 . ".\\(?:]\\)")
                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                (94 . ".\\(?:=\\)")
                (119 . ".\\(?:ww\\)")
                (123 . ".\\(?:-\\)")
                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
            )))
            (dolist
                (char-regexp alist)
                (set-char-table-range composition-function-table
                    (car char-regexp)
                    `([,(cdr char-regexp) 0 font-shape-gstring])
                )
            )
        )
    )
)

;; Customize frame behaviour (only when in GUI mode)
(use-package frame
    ;; TODO: framegeometry load and save should be a plugin
    :if window-system
    :bind (
        ("M-RET" . toggle-frame-fullscreen)
    )
    :config (progn
        (setq frame-title-format "emacs")
        (tool-bar-mode -1); Don't show the toolbar
        (scroll-bar-mode -1); Don't show the scrollbar
        ;; Save the frame size and position when exiting, and load'em on boot.
        (add-hook 'after-init-hook '(lambda ()
            "Load last frame geometry from a a file."
            (let
                (
                    (framegeometry-file (expand-file-name "_framegeometry" user-emacs-directory))
                )
                (when (file-readable-p framegeometry-file) (load-file framegeometry-file))
            )
        ))
        (add-hook 'kill-emacs-hook '(lambda ()
            "Save current frame geometry to a file."
            (let
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
            )
        ))
    )
)

;; ------------------------------------------------------------------------------ Packages

;; Make sure Mac's $PATH is available to emacs
(use-package exec-path-from-shell
    :ensure t
    :if (file-exists-p "/usr/local/bin/bash")
    :init (setenv "SHELL" "/usr/local/bin/bash")
    :config (progn
        (setq
            exec-path-from-shell-check-startup-files nil; remove warning
            exec-path-from-shell-variables '("PATH" "MANPATH")
        )
        (exec-path-from-shell-initialize)
    )
)

;; Try packages before installing.
(use-package try :ensure t)

;; Adds a command for restarting emacs
(use-package restart-emacs :ensure t)

;; Improve emacs' help system
(use-package help+ :ensure t)
(use-package help-fns+ :ensure t)
(use-package help-mode+ :ensure t)

;; Use common key-bindings for zooming the frame.
(use-package zoom-frm
    :ensure t
    :if window-system
    :config (progn
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
(use-package rainbow-mode
    :ensure t
    :if window-system
)

;; Improve default functionality for dired
(use-package dired+
    :ensure t
    :config (progn
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Add jump to current file's folder
            (global-set-key (kbd "C-x C-j") nil);original binding
            (evil-leader/set-key "." 'dired-jump)
        ))
        ;;Use evil on dired mode
        (eval-after-load 'dired '(lambda ()
            (add-hook 'evil-local-mode-hook '(lambda ()
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
        ))
        ;; reuse the dired buffer when moving betweenn directories
        (diredp-toggle-find-file-reuse-dir 1)
    )
)

;; Show all available mas when key is pressed. (after a timeout)
(use-package which-key
    :ensure t
    :delight which-key-mode
    :config (which-key-mode)
)

;; Wait what? numbers don't get a highlight on emacs? fix it.
(use-package highlight-numbers
    :ensure t
    :delight highlight-numbers-mode
    :config (add-hook 'prog-mode-hook 'highlight-numbers-mode)
)

;; What? no highlighted quotes for lisp either? c'mon man!
(use-package highlight-quoted
    :ensure t
    :delight highlight-quoted-mode
    :config (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
)

;; VI rocks! there, I said it.
(use-package evil
    :ensure t
    :config (progn
        ;; Enable tpope's vim-commentary port
        (use-package evil-commentary
            :ensure t
            :delight evil-commentary-mode
        )
        ;; Enable tpope's vim-surround port (globally)
        (use-package evil-surround
            :ensure t
            :delight evil-surround-mode
            :config (global-evil-surround-mode 1)
        )
        ;; Enable the <leader> key like in Vim
        (use-package evil-leader
            :ensure t
            :config (global-evil-leader-mode 1)
        )
        ;; Enable multiple-cursors
        (use-package evil-mc
            :ensure t
            :delight evil-mc-mode
            :config (global-evil-mc-mode 1)

        )
        ;; Enable comentary mode only on programming mode
        (add-hook 'prog-mode-hook 'evil-commentary-mode)
        ;; To avoid issues load these after emacs has initialized
        (add-hook 'evil-local-mode-hook '(lambda ()
            (evil-leader/set-leader "SPC")
            ;; Auto indent after paste
            (fset 'indent-pasted-text "`[v`]=")
            (evil-leader/set-key "p" 'indent-pasted-text)
            (evil-leader/set-key "?" 'which-key-show-top-level)
            ;; Have <tab> to work as it does on Vim
            (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
            (define-key evil-motion-state-map (kbd "C-b") nil); scroll down
            ;; Override evil-mc key bindings
            (let
                ((keys '(
                    ("grm" . nil)
                    ("gru" . nil)
                    ("grs" . nil)
                    ("grr" . nil)
                    ("grf" . nil)
                    ("grl" . nil)
                    ("grh" . nil)
                    ("grj" . nil)
                    ("grk" . nil)
                    ("grN" . nil)
                    ("grn" . nil)
                    ("grp" . nil)
                    ("grP" . nil)
                    ("M-j" . evil-mc-make-cursor-move-next-line)
                    ("M-k" . evil-mc-make-cursor-move-prev-line)
                    ("M-P" . evil-mc-make-and-goto-prev-cursor)
                    ("M-N" . evil-mc-make-and-goto-next-cursor)
                    ("M-n" . evil-mc-make-and-goto-next-match)
                    ("M-p" . evil-mc-make-and-goto-prev-match)
                    ("M-x" . evil-mc-skip-and-goto-next-match)
                    ("M-X" . evil-mc-undo-all-cursors)
                    ("C-n" . nil)
                    ("C-p" . nil)
                    ("C-t" . nil)
                )))
                (dolist (key-data keys)
                    (evil-define-key 'normal evil-mc-key-map (kbd (car key-data)) (cdr key-data))
                    (evil-define-key 'visual evil-mc-key-map (kbd (car key-data)) (cdr key-data))
                )
            )
        ))
        ;; Enable evil-mode baby!
        (evil-mode 1)
    )
)

;; The CtrlP of Emacs, just better.
(use-package helm
    :ensure t
    :delight helm-mode
    :config (progn
        (require 'helm-config)
        ;; Make sure helm-silver-searcher is installed
        (use-package helm-ag :ensure t)
        ;; Enable fuzzy matching
        (setq-default
            helm-candidate-number-limit 100
            helm-mode-fuzzy-match t
            helm-completion-in-region-fuzzy-match t
            helm-autoresize-mode t
            helm-buffer-max-length 50
            ;; Try to update faster when hitting RET too quickly
            helm-idle-delay 0.0
            helm-input-idle-delay 0.0
            helm-yas-display-key-on-candidate t
            helm-quick-update t
            helm-M-x-requires-pattern nil
            helm-ff-skip-boring-files t
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            (evil-leader/set-key "DEL" 'helm-mini)
            (evil-leader/set-key "SPC" 'helm-M-x)
            ;; Map the helm help
            (global-set-key (kbd "C-x c a") nil); The original helm-apropos binding
            (global-set-key (kbd "C-h C-h") nil); The emacs help for help
            (global-set-key (kbd "C-h C-h") 'helm-apropos)
            ;; Map the dynamic kill-ring
            (global-set-key (kbd "M-v") nil); The scroll-down-command
            (global-set-key (kbd "C-x c M-y") nil); The original helm-show-kill-ring
            (global-set-key (kbd "M-v") 'helm-show-kill-ring)
            ;; Map the dynamic-text search
            (global-set-key (kbd "C-s") nil); isearch-forward
            (global-set-key (kbd "C-s") 'helm-occur)
        ))
        ; Disable the "I Do" mode, we have helm for that now.
        (ido-mode -1)
        (helm-mode 1)
    )
)

;; Workspace management via perspectives
(use-package persp-mode
    :ensure t
    :delight persp-mode
    :config (progn
        (setq
            persp-autokill-buffer-on-remove 'kill ; kill the buffer when closed
            persp-nil-name "nil"; The name of the default perspective
            persp-save-dir "~/.emacs.d/_perspectives/"
            persp-auto-save-fname "autosave"
            persp-set-last-persp-for-new-frames nil; don't use last persp for new frames
            persp-auto-save-opt 1; Auto-save perspective on buffer kill
            persp-auto-resume-time 1; Load perspectives on startup
            persp-nil-hidden t; hide the nil perspective
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
        (add-hook 'evil-local-mode-hook '(lambda ()
            (evil-leader/set-key "TAB" 'persp-switch);; quick perspective switch
            (global-set-key (kbd "C-b") nil); backward_char
            (global-set-key (kbd "C-b") 'persp-switch-to-buffer)
            (global-set-key (kbd "C-B") 'persp-kill-buffer)
            (global-set-key (kbd "M-w") nil); kill-ring-save
            (global-set-key (kbd "M-w") 'kill-this-buffer)
        ))
        (with-eval-after-load "persp-mode"
            ;; always kill buffer using persp-mode
            (substitute-key-definition 'kill-buffer 'persp-kill-buffer global-map)
        )
        (persp-mode 1)
    )
)

;; Quick switching files
(use-package projectile
    :ensure t
    :delight projectile-mode
    :config (progn
        ;; Enable helm-projectile-integration
        (use-package helm-projectile :ensure t)
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; make C-/ trigger helm-ag instead of undo-tree's undo
            (define-key undo-tree-map (kbd "C-/") nil); undo-tree-undo
            (global-set-key (kbd "C-/") 'helm-projectile-ag)
            ;; Enable helm-projectile
            (define-key evil-motion-state-map (kbd "C-f") nil); scroll up
            (global-set-key (kbd "C-f") 'helm-projectile)
            ;; Enable finding directories
            (define-key evil-motion-state-map (kbd "C-d") nil); scroll down
            (global-set-key (kbd "C-d") 'helm-projectile-find-dir)
        ))
        (projectile-mode 1)
    )
)

;; Enable version control using Magit (fugitive alternative)
(use-package magit
    :ensure t
    :config (add-hook 'evil-local-mode-hook '(lambda ()
        (evil-leader/set-key "gs" 'magit-status)
        (evil-leader/set-key "gc" 'magit-commit)
        (evil-leader/set-key "gp" 'magit-push)
        (evil-leader/set-key "gd" 'vc-diff)
        (evil-leader/set-key "g+" 'git-gutter:stage-hunk)
        (evil-leader/set-key "g-" 'git-gutter:revert-hunk)
        (evil-leader/set-key "g}" 'git-gutter:next-hunk)
        (evil-leader/set-key "g{" 'git-gutter:previous-hunk)
    ))
)

;; Autocompletion
(use-package company
    :ensure t
    :delight company-mode
    :config (progn
        ;; Enable company in any programming mode
        (add-hook 'prog-mode-hook 'company-mode)
    )
)

;; Generate a traversable undo history for files
(use-package undo-tree
    :ensure t
    :delight undo-tree-mode
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
    :delight linum-relative-mode
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
    :delight highlight-indent-guides-mode
    :config (progn
        (setq highlight-indent-guides-method 'character)
        (setq highlight-indent-guides-auto-enabled nil); don't calculate color
        (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    )
)

;; Try to guess the current file indentation and set emacs to follow it
(use-package dtrt-indent
    :ensure t
    :delight dtrt-indent-mode " [dtrt] "
    :config (add-hook 'prog-mode-hook 'dtrt-indent-mode)
)

;; Add an indicator at the fill-column position.
(use-package fill-column-indicator
    :ensure t
    :delight fci-mode
    :config (progn
        (setq fci-rule-width 1)
        (add-hook 'prog-mode-hook 'fci-mode)
    )
)

;; Smart pairs
(use-package smartparens
    :ensure t
    :delight smartparens-mode
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
(use-package git-gutter
    :ensure t
    :delight git-gutter-mode
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
;; (use-package centered-cursor-mode
;;     :ensure t
;;     :delight centered-cursor-mode
;;     :config (progn
;;         (define-key ccm-map [(meta v)] nil); disable keymap so it can be used elsewhere
;;         (add-hook 'prog-mode-hook 'centered-cursor-mode)
;;     )
;; )

;; Show a file-tree ala Vim
(use-package neotree
    :ensure t
    :config (progn
        ;; Enable theme
        (use-package all-the-icons :ensure t)
        (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
        ;; Use ffip to determine the project root and open neotree relative to it.
        (use-package find-file-in-project
            :ensure t
            :config (add-hook 'evil-local-mode-hook '(lambda ()
                (evil-leader/set-key "RET" (lambda ()
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
            ))
        )
        ;; (evil-define-ket 'normal neotree-mode-map (kbd "|") 'neotree-)
        (setq neo-smart-open t); let neotree find the current file and jump to it.
        ;; work along with projectile
        (setq projectile-switch-project-action 'neotree-projectile-action)
        ;; Don't show hidden files (they will be excluded by git)
        (setq-default neo-show-hidden-files nil)
        ;; overwrite the default hidden file filter, so it uses .gitignore
        (defun neo-util--hidden-path-filter (node)
            "it reads each nodule on the list, and determines if its ignored by git."
            (if neo-buffer--show-hidden-file-p
                ;; all files should be shown
                node
                ;; hiding is enabled, use git check-ignore to determeine which to show
                (if
                    ;; if the output is empty (file should be shown) return the node
                    (string= (string-trim (shell-command-to-string (format
                        "git -C %s check-ignore %s"
                        (file-name-directory node)
                        node
                    ))) "")
                    node
                    ;; git outputed something, file shold be hidden
                    nil
                )
            )
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Allow to use evil mode with neotree
            (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
            (evil-define-key 'normal neotree-mode-map (kbd "<f5>") 'neotree-refresh)
            (evil-define-key 'normal neotree-mode-map (kbd "<escape>") 'neotree-toggle)
            (evil-define-key 'normal neotree-mode-map (kbd "m") 'neotree-rename-node)
            (evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
            (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-create-node)
        ))
    )
)

;; Allows easier movement from window to window
(use-package ace-window
    :ensure t
    :delight ace-window-mode
    :config (progn
        ;; Set the font-face for the ace-window indicator
        (custom-set-faces
            '(aw-leading-char-face ((t (
                :inherit ace-jump-face-foreground
                :foreground "#FFFFFF"
                :height 3.0))
            ))
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Replace "other-window"
            (global-set-key [remap other-window] 'ace-window)
            ;; Disable the usual bindings for window management
            (global-set-key (kbd "C-x 0") nil); closes window
            (global-set-key (kbd "C-x 1") nil); delete other windows
            (global-set-key (kbd "C-x 2") nil); splits window horizontally
            (global-set-key (kbd "C-x 3") nil); splits window vertically
            ;; when splitting windows, always balance windows
            (evil-leader/set-key "w|" '(lambda ()
                (interactive)
                (split-window-horizontally)
                (balance-windows)
                (other-window 1 nil)
            ))
            (evil-leader/set-key "w-" (lambda ()
                (interactive)
                (split-window-vertically)
                (balance-windows)
                (other-window 1 nil)
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
        ))
    )
)

;; A Powerline replacement.
(use-package telephone-line
    :ensure t
    :config (progn
        (require 'telephone-line-utils)

        (telephone-line-defsegment* telephone-line-project-segment () (telephone-line-raw
            (concat persp-last-persp-name ":" (projectile-project-name) "  ")
        ))

        (setq
            telephone-line-height 20
            telephone-line-evil-use-short-tag t
            ;; Left separators
            telephone-line-primary-left-separator 'telephone-line-identity-left
            telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left
            ;; Right separators
            telephone-line-primary-right-separator 'telephone-line-identity-left
            telephone-line-secondary-right-separator 'telephone-line-identity-hollow-left
            ;; The left segments
            telephone-line-lhs '(
                (evil . (telephone-line-evil-tag-segment)); Evil-mode status
                (accent . (telephone-line-vc-segment)); Version control status
                (nil . (telephone-line-buffer-segment)); Buffer info
            )
            ;; The right segments
            telephone-line-rhs '(
                (nil . (
                    telephone-line-airline-position-segment
                    telephone-line-major-mode-segment
                ))
                (accent . (telephone-line-minor-mode-segment))
                (evil . (telephone-line-project-segment))
            )
        )
        (telephone-line-mode 1)
    )
)

;; Log working time on wakatime.com
(if (file-exists-p "/usr/local/bin/wakatime") (use-package wakatime-mode
    :ensure t
    :delight wakatime-mode " Ϣ"
    :config (progn
        (setq
            wakatime-cli-path "/usr/local/bin/wakatime"
            wakatime-python-bin "/usr/local/bin/python"
        )
        (global-wakatime-mode 1)
    )
))

;; Replace the word lambda with the greek character (without using pretty symbols)
(use-package pretty-lambdada
    :ensure t
    :config (progn
        (add-hook 'prog-mode-hook 'pretty-lambda-mode)
    )
)

;; Highlight TODOs
(use-package hl-todo
    :ensure t
    :init (add-hook 'prog-mode-hook 'hl-todo-mode)
    :bind (
        ("C-c t n" . hl-todo-next)
        ("C-c t p" . hl-todo-previous)
        ("C-c C-t" . hl-todo-occur)
    )
)

;; Make NVM available
(use-package nvm
    :if (file-exists-p "~/.nvm")
    :ensure t
    :config (nvm-use (caar (last (nvm--installed-versions))))
)

;; enable jump-to definition
(use-package dumb-jump
    :ensure t
    :config (progn
        (setq-default
            dumb-jump-prefer-searcher 'ag
            dumb-jump-selector 'helm
        )
        (add-hook 'evil-local-mode-hook '(lambda ()
            ;; Key bindings for evil-mode
            (evil-leader/set-key "jj" 'dumb-jump-go)
            (evil-leader/set-key "jJ" 'dumb-jump-back)
        ))
        (add-hook 'prog-mode-hook 'dumb-jump-mode)
    )
)

;; Enable Json mode
(use-package json-mode
    :ensure t
    :commands json-mode
    :mode ("\\.json\\'" . json-mode)
)

;; Enable Javascript mode
(use-package js2-mode
    :ensure t
    :interpreter "node"
    :mode (("\\.js\\'" . js2-mode))
    :config (progn
        (use-package simple-httpd :ensure t)
        (use-package skewer-mode
            :ensure t
            :delight skewer-mode
            :config (progn
                (add-hook 'js2-mode-hook 'skewer-mode)
                (add-hook 'css-mode-hook 'skewer-css-mode)
                (add-hook 'html-mode-hook 'skewer-html-mode)
            )
        )
        ;; Enable contex-sensitive auto-completion (depends on skewer-mode too)
        (use-package ac-js2
            :ensure t
            :config (progn
                (setq ac-js2-evaluate-calls t)
                (add-hook 'js2-mode-hook 'ac-js2-mode)
            )
        )
        ;; Enable tern
        (use-package tern
            :ensure t
            :config (progn
                (add-hook 'js2-mode-hook 'tern-mode)
                (setq-default tern-command (append tern-command '("--no-port-file")))
                ;; Add tern to copany backends.
                (use-package company-tern
                    :ensure t
                    :init (add-to-list 'company-backends 'company-tern)
                    :config (setq company-tern-property-marker nil)
                )
            )
        )
        (setq-default
            js2-basic-offset 4
            js2-highlight-level 3
            js2-auto-indent-p t
            js2-indent-switch-body t
            js2-indent-on-enter-key t
            js2-include-browser-externs t
            js2-include-node-externs t
            js2-warn-about-unused-function-arguments t
            ;; let flycheck handle parse errors
            js2-mode-show-parse-errors nil
            js2-strict-missing-semi-warning nil
            js2-strict-trailing-comma-warning nil
            js2-strict-cond-assign-warning nil
            js2-strict-inconsistent-return-warning nil
            js2-strict-var-hides-function-arg-warning nil
            js2-strict-var-redeclaration-warning nil
        )
        (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
    )
)

;; Enable JSX syntax support
(use-package rjsx-mode
    :ensure t
    :config (add-hook 'rjsx-mode-hook (lambda ()
        (define-key rjsx-mode-map "<" nil); This behaviour made emacs hang, so disabled it
        (setq
            sgml-basic-offset tab-width; Indent tags like everything else
            sgml-attribute-offset 0; use the same spacing as the basic offset
        )
    ))
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
        (setq
            flycheck-temp-prefix ".flycheck"
            flycheck-mode-line-prefix " ✖︎"
        )
        (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
        (flycheck-add-mode 'javascript-eslint 'js2-mode)
        (add-hook 'prog-mode-hook 'global-flycheck-mode)
    )
)

(use-package markdown-mode
    :ensure t
    :mode (
        ("README\\.md\\'" . gfm-mode); Use github flavored markdown
        ("\\.md\\'" . markdown-mode)
        ("\\.markdown\\'" . markdown-mode)
    )
)

;; Enable typescript syntax-support
(use-package typescript-mode
    :ensure t
    :config (progn
        (setq typescript-indent-level 2)
    )
)

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

(provide 'emacs)

;;; emacs ends here
