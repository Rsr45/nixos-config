{
  pkgs,
  pkgsUnstable,
  inputs,
  config,
  ...
}: let
  inherit (builtins) toString;
in {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraConfig = ''
      (add-to-list 'default-frame-alist
             '(font . "${config.stylix.fonts.monospace.name}-${toString config.stylix.fonts.sizes.terminal}"))

      ${builtins.readFile ./emacs.el}
    '';
    extraPackages = epkgs:
      with epkgs; [
        nix-mode
        nix-ts-mode
        markdown-mode
        haskell-mode
        rust-mode
        typescript-mode
        go-mode
        clojure-mode
        # dap-mode
        straight
        tree-sitter
        # parinfer-rust-mode
        # flycheck
        # flycheck-rust
        # flycheck-golangci-lint
        treesit-grammars.with-all-grammars
        tree-sitter-langs
        vterm
        evil
        evil-collection
        evil-surround
        dirvish
        dired-narrow
        dired-filter
        denote
        kdeconnect
        magit
        vi-tilde-fringe
        marginalia
        apheleia
        fussy
        hotfuzz
        corfu
        fzf
        cape
        pkgsUnstable.emacsPackages.vertico
        fzf-native
        # orderless
        consult
        flash
        page-break-lines
        direnv
      ];
  };

  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs; # replace with pkgs.emacs-gtk if desired
  #   extraPackages = epkgs: [
  #     epkgs.nix-mode
  #     epkgs.nixfmt
  #   ];
  #   extraConfig = ''
  #     (setq standard-indent 2)
  #   '';
  # };
  #
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacsWithPackagesFromUsePackage {
  #     config = pkgs.writeTextFile {
  #       text = ''
  #         ${builtins.readFile ./emacs.el}
  #         #+begin_src emacs-lisp
  #         ${config.home-manager.users.hare.programs.emacs.extraConfig}
  #         #+end_src'';
  #       name = "config.org";
  #     };
  #     alwaysTangle = true;
  #     defaultInitFile = true;
  #     package = pkgs.emacs-pgtk;
  #     extraEmacsPackages = config.home-manager.users.hare.programs.emacs.extraPackages;
  #   };
  # };

  # programs.emacs = {
  #   enable = true;
  #   package = with pkgs;
  #     (emacsPackagesFor emacs).emacsWithPackages (
  #       epkgs: [epkgs.vterm]
  #     );
  #   # package = pkgs.emacs.pkgs.withPackages (epkgs: [
  #   #   (epkgs.treesit-grammars.with-grammars (grammars: [grammars.tree-sitter-bash]))
  #   # ]);
  #   # extraPackages = epkgs: [
  #   #   epkgs.tree-sitter-langs
  #   #   epkgs.treesit-grammars
  #   # ];
  #   extraConfig = ''
  #     ;; straight.el
  #     (defvar bootstrap-version)
  #     (let ((bootstrap-file
  #            (expand-file-name
  #             "straight/repos/straight.el/bootstrap.el"
  #             (or (bound-and-true-p straight-base-dir)
  #                 user-emacs-directory)))
  #           (bootstrap-version 7))
  #       (unless (file-exists-p bootstrap-file)
  #         (with-current-buffer
  #             (url-retrieve-synchronously
  #              "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
  #              'silent 'inhibit-cookies)
  #           (goto-char (point-max))
  #           (eval-print-last-sexp)))
  #       (load bootstrap-file nil 'nomessage))
  #
  #     (straight-use-package 'use-package)
  #     (setq straight-use-package-by-default t)
  #
  #     ;; evil
  #     (use-package goto-chg
  #       :demand t)
  #     (use-package evil
  #       :demand t
  #       :init
  #       (setq evil-want-C-u-scroll t
  #             evil-want-C-i-jump t
  #             evil-vsplit-window-right t
  #             evil-split-window-below t
  #             evil-undo-system 'undo-redo)
  #       (setq evil-want-keybinding nil) ; evil-collection
  #       :config
  #       (evil-mode 1))
  #
  #     ;; evil everywhere
  #     (use-package evil-collection
  #       :demand t
  #       :after evil
  #       :custom
  #       (evil-collection-setup-minibuffer t)
  #       :config
  #       (evil-collection-init)
  #       (setq evil-collection-binding-overrides
  #             '((history-previous     :state normal :key "C-p")
  #               (history-next         :state normal :key "C-n")
  #               (completion-previous  :state insert :key "C-p")
  #               (completion-next      :state insert :key "C-n")))
  #       )
  #
  #     ;; flash.el
  #     (use-package flash
  #       :demand t
  #       :after evil
  #       :commands (flash-jump flash-jump-continue flash-action flash-action-undo
  #                             flash-treesitter)
  #       :custom
  #       (flash-labels "strdnaei")
  #       (flash-label-uppercase nil)     ; double available labels (a-z + A-Z)
  #       (flash-autojump nil)            ; auto-jump when single match
  #       (flash-multi-window t)
  #       (flash-backdrop t)          ; no dimming
  #       (flash-rainbow nil)             ; colorful labels
  #       (flash-highlight-matches t)
  #       (flash-label-position 'overlay)
  #       (flash-char-jump-labels t)    ; labels on f/t/F/T matches
  #       (flash-nohlsearch t)          ; clear highlight after jump
  #       :init
  #       (with-eval-after-load 'evil
  #         (require 'flash-evil)
  #         (flash-evil-setup t))  ; t = also set up f/t/F/T char motions
  #       )
  #
  #     ;; opts
  #     (menu-bar-mode -1)
  #     (scroll-bar-mode -1)
  #     (tool-bar-mode -1)
  #     ;; (defalias 'yes-or-no-p 'y-or-n-p)
  #     (set-charset-priority 'unicode)
  #     (setq locale-coding-system 'utf-8
  #           coding-system-for-read 'utf-8
  #           coding-system-for-write 'utf-8)
  #     (set-terminal-coding-system 'utf-8)
  #     (set-keyboard-coding-system 'utf-8)
  #     (set-selection-coding-system 'utf-8)
  #     (prefer-coding-system 'utf-8)
  #     (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  #     (recentf-mode 1)
  #     ;; (setq read-buffer-completion-ignore-case t
  #     ;;       read-file-name-completion-ignore-case t)
  #     (setq blink-cursor-mode nil)
  #
  #     (setq-default indent-tabs-mode nil)
  #     (setq-default tab-width 4)
  #
  #     (setopt use-short-answers t)
  #
  #     (setq display-line-numbers-type 'relative)
  #     ;; (global-display-line-numbers-mode 1)
  #     (global-whitespace-mode 1)
  #                                             ; (setq dired-hide-details-mode t)
  #     (setq whitespace-style '(trailing tabs tab-mark))
  #     ;; (setq which-key-mode t)
  #     (require 'which-key)
  #     (with-eval-after-load 'which-key
  #       (which-key-mode 1))
  #
  #
  #     (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  #     (load custom-file 'noerror 'nomessage)
  #
  #
  #     (evil-set-leader '(normal visual) (kbd "SPC"))
  #     ;; (evil-set-leader '(normal visual) (kbd ";"))
  #
  #     (global-unset-key (kbd "C-SPC"))
  #     (with-eval-after-load 'corfu
  #       (evil-define-key '(insert normal) 'global (kbd "C-y") 'corfu-insert)
  #       )
  #
  #     (evil-define-key '(insert normal) 'global (kbd "C-SPC") 'completion-at-point)
  #     (evil-define-key 'normal 'global (kbd "C-n") 'evil-next-line)
  #     (evil-define-key 'normal 'global (kbd "C-p") 'evil-previous-line)
  #
  #     ;; (defun my-dired-toggle-mark ()
  #     ;;   (interactive)
  #     ;;   (if (eq (char-after (line-beginning-position)) dired-marker-char)
  #     ;;       (dired-unmark 1)
  #     ;;     (dired-mark 1)))
  #     ;; (defun my-dired-toggle-mark ()
  #     ;;   (interactive)
  #     ;;   (if (evil-visual-state-p)
  #     ;;       (let ((beg (line-beginning-position))
  #     ;;             (end (save-excursion
  #     ;;                    (goto-char (region-end))
  #     ;;                    (line-beginning-position)))
  #     ;;             (all-marked t))
  #     ;;         (save-excursion
  #     ;;           (goto-char beg)
  #     ;;           (while (<= (point) end)
  #     ;;             (unless (eq (char-after (line-beginning-position))
  #     ;;                         dired-marker-char)
  #     ;;               (setq all-marked nil))
  #     ;;             (forward-line 1)))
  #     ;;         (if all-marked
  #     ;;             (my-dired-unmark-region-files)
  #     ;;           (my-dired-mark-region-files))
  #     ;;         (evil-exit-visual-state))
  #     ;;     (if (eq (char-after (line-beginning-position)) dired-marker-char)
  #     ;;         (dired-unmark 1)
  #     ;;       (dired-mark 1))))
  #
  #     (defun my-dired-toggle-mark ()
  #       (interactive)
  #       (if (use-region-p)
  #           (let ((beg (region-beginning))
  #                 (end (region-end))
  #                 (all-marked t))
  #             (save-excursion
  #               (goto-char beg)
  #               (while (< (point) end)
  #                 (unless (eq (char-after (line-beginning-position))
  #                             dired-marker-char)
  #                   (setq all-marked nil))
  #                 (forward-line 1)))
  #             (if all-marked
  #                 (my-dired-unmark-region-files)
  #               (my-dired-mark-region-files))
  #             (when (evil-visual-state-p)
  #               (evil-exit-visual-state)))
  #         (if (eq (char-after (line-beginning-position)) dired-marker-char)
  #             (dired-unmark 1)
  #           (dired-mark 1))))
  #
  #
  #
  #     ;; dired keybinds
  #     (with-eval-after-load 'dired
  #       (evil-define-key 'normal dired-mode-map
  #         (kbd "SPC") nil
  #         (kbd "<left>") 'dired-up-directory
  #         (kbd "<right>") 'dired-find-file
  #         (kbd "<up>") nil
  #         (kbd "<down>") nil
  #         (kbd "<up>") 'dired-previous-line
  #         (kbd "<down>") 'dired-next-line
  #         (kbd "k") 'dired-do-kill-lines
  #         (kbd "C-r") 'dired-do-redisplay
  #         (kbd "<mouse-1>") 'dired-find-file
  #         (kbd "<mouse-2>") 'dired-mouse-find-file
  #         (kbd "^") nil
  #         (kbd "-") nil
  #         (kbd "m") 'my-dired-toggle-mark
  #         ;; (kbd "M") 'diredp-mark-region-files
  #         (kbd "u") nil
  #         (kbd "u") 'dired-unmark-all-marks
  #         (kbd "U") nil
  #         ;; (kbd "U") 'revert-buffer
  #         (kbd ";") nil
  #         (kbd "r") nil
  #         (kbd "r") 'dired-do-rename
  #         (kbd "R") nil
  #         (kbd "R") 'wdired-change-to-wdired-mode
  #         ;; (kbd "i") nil
  #         (kbd "a") nil
  #         (kbd ".") nil
  #         (kbd "gs") 'find-file
  #         (kbd ";c") 'emacspeak-dired-zoxide
  #         (kbd ";C") 'emacspeak-consult-zoxide
  #         (kbd ";n") 'dired-get-total-size
  #         (kbd "f") nil
  #         ;; (kbd "f") 'my-fd-dired
  #         (kbd "o") nil
  #         (kbd "o") 'dired-omit-mode
  #         )
  #       )
  #
  #     ;; (defun my-dirvish-fd ()
  #     ;;   (interactive)
  #     ;;   (let ((current-prefix-arg '(4)))
  #     ;;     (call-interactively #'dirvish-fd)))
  #
  #     (defun my-dirvish-fd ()
  #       (interactive)
  #       (let ((current-prefix-arg '(16)))
  #         (call-interactively #'dirvish-fd)))
  #
  #     (defun my-fd-dired (query)
  #       (interactive "sSearch: ")
  #       (let ((directory (dired-current-directory))
  #             (files
  #              (split-string
  #               (shell-command-to-string
  #                (format "fd --type f %s %s"
  #                        (shell-quote-argument query)
  #                        (shell-quote-argument (dired-current-directory))))
  #               "\n" t)))
  #         (dired (cons (format "*fd: %s*" query) files))))
  #
  #     ;; (defun my-fd-dired (query)
  #     ;;   (interactive "sSearch: ")
  #     ;;   (let* ((directory (dired-current-directory))
  #     ;;          (files (process-lines "fd"
  #     ;;                                "--type" "f"
  #     ;;                                "--absolute-path"
  #     ;;                                query
  #     ;;                                directory)))
  #     ;;     (dired (cons (format "*fd: %s*" query) files))))
  #
  #     ;; (defun my-fd-dired (query)
  #     ;;   (interactive "sSearch: ")
  #     ;;   (let* ((directory (dired-current-directory))
  #     ;;          (files (process-lines
  #     ;;                  "fd"
  #     ;;                  "--type" "f"
  #     ;;                  "--absolute-path"
  #     ;;                  query
  #     ;;                  directory)))
  #     ;;     (switch-to-buffer
  #     ;;      (dired-noselect (cons directory files)))))
  #
  #     ;; (defun my-fd-dired (query)
  #     ;;   (interactive "sSearch: ")
  #     ;;   (let ((dir (dired-current-directory)))
  #     ;;     (find-dired-with-command
  #     ;;      dir
  #     ;;      (format "fd --type f --absolute-path %s %s -X ls -ld"
  #     ;;              (shell-quote-argument query)
  #     ;;              (shell-quote-argument dir)))))
  #
  #     (defun dired-get-total-size ()
  #       (interactive)
  #       (dired-do-shell-command "du -sh" nil (dired-get-marked-files)))
  #
  #
  #     ;; (defun my-dired-mark-region-files (&optional unmark-p)
  #     ;;   "Mark all files in the current region.
  #     ;; With non-nil prefix argument, unmark them instead."
  #     ;;   (interactive "P")
  #     ;;   (let ((beg (min (point) (mark)))
  #     ;;         (end (max (point) (mark)))
  #     ;;         (inhibit-field-text-motion t))
  #     ;;     (setq beg (save-excursion
  #     ;;                 (goto-char beg)
  #     ;;                 (line-beginning-position))
  #     ;;           end (save-excursion
  #     ;;                 (goto-char end)
  #     ;;                 (when (and (bolp) (> end beg))
  #     ;;                   (backward-char))
  #     ;;                 (line-end-position)))
  #     ;;     (save-excursion
  #     ;;       (goto-char beg)
  #     ;;       (while (<= (point) end)
  #     ;;         (when (dired-get-filename nil t)
  #     ;;           (if unmark-p
  #     ;;               (dired-unmark 1)
  #     ;;             (dired-mark 1)))))))
  #
  #     ;; (defun my-dired-unmark-region-files (&optional mark-p)
  #     ;;   "Unmark all files in the current region.
  #     ;; With non-nil prefix argument, mark them instead."
  #     ;;   (interactive "P")
  #     ;;   (let ((beg (min (point) (mark)))
  #     ;;         (end (max (point) (mark)))
  #     ;;         (inhibit-field-text-motion t))
  #     ;;     (setq beg (save-excursion
  #     ;;                 (goto-char beg)
  #     ;;                 (line-beginning-position))
  #     ;;           end (save-excursion
  #     ;;                 (goto-char end)
  #     ;;                 (when (and (bolp) (> end beg))
  #     ;;                   (backward-char))
  #     ;;                 (line-end-position)))
  #     ;;     (save-excursion
  #     ;;       (goto-char beg)
  #     ;;       (while (<= (point) end)
  #     ;;         (when (dired-get-filename nil t)
  #     ;;           (if mark-p
  #     ;;               (dired-mark 1)
  #     ;;             (dired-unmark 1)))))))
  #
  #     (defun my-dired-mark-region-files (&optional unmark-p)
  #       "Mark all files in the current region.
  #     With non-nil prefix argument, unmark them instead."
  #       (interactive "P")
  #       (let ((beg (min (point) (mark)))
  #             (end (max (point) (mark)))
  #             (inhibit-field-text-motion t))
  #         (setq beg (save-excursion
  #                     (goto-char beg)
  #                     (line-beginning-position))
  #               end (save-excursion
  #                     (goto-char end)
  #                     (when (and (bolp) (> end beg))
  #                       (backward-char))
  #                     (line-end-position)))
  #         (save-excursion
  #           (goto-char beg)
  #           (while (<= (point) end)
  #             (if (dired-get-filename nil t)
  #                 (if unmark-p
  #                     (dired-unmark 1)
  #                   (dired-mark 1))
  #               (forward-line 1))))))
  #
  #     (defun my-dired-unmark-region-files (&optional mark-p)
  #       "Unmark all files in the current region.
  #     With non-nil prefix argument, mark them instead."
  #       (interactive "P")
  #       (let ((beg (min (point) (mark)))
  #             (end (max (point) (mark)))
  #             (inhibit-field-text-motion t))
  #         (setq beg (save-excursion
  #                     (goto-char beg)
  #                     (line-beginning-position))
  #               end (save-excursion
  #                     (goto-char end)
  #                     (when (and (bolp) (> end beg))
  #                       (backward-char))
  #                     (line-end-position)))
  #         (save-excursion
  #           (goto-char beg)
  #           (while (<= (point) end)
  #             (if (dired-get-filename nil t)
  #                 (if mark-p
  #                     (dired-mark 1)
  #                   (dired-unmark 1))
  #               (forward-line 1))))))
  #
  #
  #     (defun my-dired-shift-mark ()
  #       (interactive)
  #       (if (region-active-p)
  #           (progn
  #             (exchange-point-and-mark)
  #             (my-dired-mark-region-files)
  #             (deactivate-mark))
  #         (push-mark-command nil)))
  #
  #     (defun my-dired-shift-mark-combo ()
  #       (interactive)
  #       (if (region-active-p)
  #           (my-dired-mark-region-files)
  #         (my-dired-shift-mark)))
  #
  #
  #
  #     ;; (defun my-shift-click (event)
  #     ;;   (interactive "e")
  #     ;;   (if (region-active-p)
  #     ;;       (let ((click-pos (posn-point (event-start event))))
  #     ;;         (when (< (abs (- click-pos (mark))) (abs (- click-pos (point))))
  #     ;;           (exchange-point-and-mark)))
  #     ;;     (push-mark-command nil))
  #     ;;   (mouse-set-point event))
  #
  #     ;; (define-key global-map (kbd "<S-down-mouse-1>") 'my-shift-click)
  #     ;; (define-key global-map (kbd "<S-mouse-1>") 'ignore)
  #
  #     ;; default must have keybinds
  #     (evil-define-key 'normal 'global (kbd "C-a") 'mark-whole-buffer)
  #     (global-set-key (kbd "C-S-c") 'evil-yank)
  #     (global-set-key (kbd "C-S-v") 'evil-paste-after)
  #     (evil-define-key 'normal 'global (kbd "<leader>SPC") 'my-consult-fd)
  #     (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  #     (evil-define-key 'normal 'global (kbd "<leader>fg") 'consult-ripgrep)
  #     (evil-define-key 'normal 'global (kbd "<leader>fs") 'consult-line)
  #     (evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-buffer)
  #     (evil-define-key 'normal 'global (kbd "<leader>fd") 'dirvish) ;dired-jump
  #     (evil-define-key 'normal 'global (kbd "<leader>fD") 'emacspeak-dired-zoxide)
  #     (evil-define-key 'normal 'global (kbd "<leader>fc") 'emacspeak-consult-zoxide)
  #     (evil-define-key 'normal 'global (kbd "<leader>fo") 'open-file-external)
  #     (evil-define-key 'normal 'global (kbd "<down>") 'evil-next-visual-line)
  #     (evil-define-key 'normal 'global (kbd "<up>") 'evil-previous-visual-line)
  #     (evil-define-key 'normal 'global (kbd "<leader>cs") 'evil-update)
  #     (evil-define-key 'normal 'global (kbd "<leader>bd") 'evil-delete-buffer)
  #     (evil-define-key 'normal 'global (kbd "<leader>;") 'execute-extended-command)
  #     (evil-define-key 'normal 'global (kbd "gcc") 'comment-line)
  #     (evil-define-key 'visual 'global (kbd "gc") 'comment-line)
  #     (evil-define-key '(normal visual) 'global (kbd "S") 'flash-jump)
  #     (with-eval-after-load 'vertico
  #       (define-key vertico-map (kbd "C-<return>") #'next-history-element)
  #       )
  #     (evil-define-key 'normal 'global (kbd "<leader>cf") 'apheleia-format-buffer)
  #
  #     (use-package apheleia
  #       :demand t
  #       :init
  #       (apheleia-global-mode +1))
  #
  #     ;; Enable Vertico.
  #     (use-package vertico
  #       :demand t
  #       :custom
  #       (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  #       ;; Option 1: Additional bindings
  #       (keymap-set vertico-map "M-?" #'minibuffer-completion-help)
  #       (keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
  #       (keymap-set vertico-map "M-TAB" #'minibuffer-complete)
  #
  #       ;; Option 2: Replace `vertico-insert' to enable TAB prefix expansion.
  #       (keymap-set vertico-map "TAB" #'minibuffer-complete)
  #       :init
  #       (vertico-mode)
  #       ;; This works with `file-name-shadow-mode' enabled.  When you are in
  #       ;; a sub-directory and use, say, `find-file' to go to your home '~/'
  #       ;; or root '/' directory, Vertico will clear the old path to keep
  #       ;; only your current input.
  #       (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)
  #       )
  #
  #     ;; When you first call `find-file' (C-x C-f by default), you do not
  #     ;; need to clear the existing file path before adding the new one.
  #     ;; Just start typing the whole path and Emacs will "shadow" the
  #     ;; current one.  For example, you are at ~/Documents/notes/file.txt
  #     ;; and you want to go to ~/.emacs.d/init.el: type the latter directly
  #     ;; and Emacs will take you there.
  #     (file-name-shadow-mode 1)
  #
  #
  #
  #     ;; `fzf`
  #     (use-package fzf-native
  #       :demand t
  #       :vc (:url "https://github.com/dangduc/fzf-native" :rev :newest))
  #
  #     (use-package fussy
  #       :demand t
  #       :config
  #       (fussy-setup-fzf)
  #       (fussy-eglot-setup)
  #       (fussy-company-setup))
  #
  #     (use-package hotfuzz
  #       :demand t
  #       )
  #
  #     (setq completion-styles
  #           '(fussy
  #             hotfuzz
  #             basic
  #             partial-completion
  #             emacs22))
  #
  #     (use-package fzf
  #       :config
  #       (setq fzf/args "-x --print-query --margin=1,0 --no-hscroll"
  #             fzf/executable "fzf"
  #             fzf/git-grep-args "-i --line-number %s"
  #             ;; command used for `fzf-grep-*` functions
  #             ;; example usage for ripgrep:
  #             ;; fzf/grep-command "rg --no-heading -nH"
  #             fzf/grep-command "grep -nrH"
  #             ;; If nil, the fzf buffer will appear at the top of the window
  #             fzf/position-bottom t
  #             fzf/window-height 15))
  #
  #     (evil-define-key 'normal 'global (kbd "<leader>SPC") 'fzf-find-file)
  #
  #     (use-package corfu
  #       :demand t
  #       :custom
  #       (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  #       (corfu-preselect 'prompt)      ;; Preselect the prompt
  #
  #       :init
  #       (global-corfu-mode)
  #       (corfu-mouse-mode)
  #       (corfu-popupinfo-mode)
  #       ;; Enable optional extension modes:
  #       ;; (corfu-history-mode)
  #       :config
  #       (keymap-unset corfu-map "RET")
  #       (setq corfu-auto t
  #             corfu-auto-delay 0.2
  #             corfu-auto-trigger "." ;; Custom trigger characters
  #             corfu-quit-no-match 'separator) ;; or t
  #       )
  #
  #
  #     (straight-use-package
  #      '(corfu-terminal
  #        :type git
  #        :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))
  #
  #     (unless (display-graphic-p)
  #       (corfu-terminal-mode +1))
  #
  #     ;; Example configuration for Consult
  #     (use-package consult
  #       :demand t
  #       :init
  #       (advice-add #'register-preview :override #'consult-register-window)
  #       (setq register-preview-delay 0.5)
  #       (setq xref-show-xrefs-function #'consult-xref
  #             xref-show-definitions-function #'consult-xref)
  #
  #       :config
  #       (setq consult-preview-key 'any)
  #       )
  #
  #     ;; Enable rich annotations using the Marginalia package
  #     (use-package marginalia
  #       :demand t
  #       ;; The :init section is always executed.
  #       :init
  #       (marginalia-mode))
  #
  #     ;; Add extensions
  #     (use-package cape
  #       :demand t
  #       ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  #       ;; Press C-c p ? to for help.
  #       :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  #       ;; Alternatively bind Cape commands individually.
  #       ;; :bind (("C-c p d" . cape-dabbrev)
  #       ;;        ("C-c p h" . cape-history)
  #       ;;        ("C-c p f" . cape-file)
  #       ;;        ...)
  #       :init
  #       ;; Add to the global default value of `completion-at-point-functions' which is
  #       ;; used by `completion-at-point'.  The order of the functions matters, the
  #       ;; first function returning a result wins.  Note that the list of buffer-local
  #       ;; completion functions takes precedence over the global list.
  #       (add-hook 'completion-at-point-functions #'cape-dabbrev)
  #       (add-hook 'completion-at-point-functions #'cape-file)
  #       (add-hook 'completion-at-point-functions #'cape-elisp-block)
  #       ;; (add-hook 'completion-at-point-functions #'cape-history)
  #       ;; ...
  #       )
  #
  #     ;; (use-package nerd-icons
  #     ;;   :demand t
  #     ;;   )
  #     ;; (use-package nerd-icons-dired
  #     ;;   :demand t
  #     ;;   :hook
  #     ;;   (dired-mode . nerd-icons-dired-mode))
  #
  #     ;; (setq dired-listing-switches "-lAhs --group-directories-first --sort=name --indicator-style=slash")
  #     ;; (setq dired-listing-switches "-lhsAvF --time-style=+%Y%m%dT%H%M%S --group-directories-first --indicator-style=slash")
  #     (setq dired-listing-switches "-lhsAvF --group-directories-first")
  #     (setq dired-mouse-drag-files t)
  #     (setq mouse-drag-and-drop-region-cross-program t)
  #     (setq mouse-1-click-follows-link nil)
  #     (setq delete-by-moving-to-trash t)
  #     (setq dired-dwim-target t  ; suggest a target for moving/copying intelligently
  #           ;; don't prompt to revert, just do it
  #           ;; dired-auto-revert-buffer #'dired-buffer-stale-p
  #           ;; Always copy/delete recursively
  #           dired-recursive-copies  'always
  #           dired-recursive-deletes 'top
  #           ;; Ask whether destination dirs should get created when copying/removing files.
  #           dired-create-destination-dirs 'ask
  #           image-dired-thumb-size 150
  #           dired-clean-up-buffers-too nil
  #           dired-clean-confirm-killing-deleted-buffers nil)
  #     (global-auto-revert-mode 1)
  #     (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  #
  #     (defun lynn/delete-first-dired-line ()
  #       (let ((inhibit-read-only t))
  #         (save-excursion
  #           (goto-char (point-min))
  #           (delete-region (point) (line-end-position))
  #           (delete-char 1))))
  #
  #     ;; (add-hook 'dired-after-readin-hook 'lynn/delete-first-dired-line)
  #
  #     (with-eval-after-load 'dired
  #       (require 'dired-x)
  #       (require 'dired-aux)
  #       (use-package dired-filter
  #         :config
  #         (setq dired-filter-revert 'always)
  #         )
  #       (use-package dired-narrow)
  #
  #       ;; (use-package dired-duplicates)
  #       ;; (use-package dired+
  #       ;;   :vc (:url "https://github.com/emacsmirror/dired-plus" :rev :newest)
  #       ;;   :demand t
  #       ;;   )
  #       ;; (use-package dired-preview)
  #       ;; ;; Default values for demo purposes
  #       ;; (setq dired-preview-delay 0.1)
  #       ;; (setq dired-preview-max-size (expt 2 300))
  #       ;; (setq dired-preview-ignored-extensions-regexp
  #       ;;       (concat "\\."
  #       ;;               "\\(gz\\|"
  #       ;;               "zst\\|"
  #       ;;               "tar\\|"
  #       ;;               "xz\\|"
  #       ;;               "rar\\|"
  #       ;;               "zip\\|"
  #       ;;               "iso\\|"
  #       ;;               "db\\|"
  #       ;;               "mp3\\|"
  #       ;;               "pptx\\|"
  #       ;;               "docx\\|"
  #       ;;               "pdf\\|"
  #       ;;               "epub"
  #       ;;               "\\)"))
  #
  #       ;; ;; Enable `dired-preview-mode' in a given Dired buffer or do it
  #       ;; ;; globally:
  #       ;; (dired-preview-global-mode 1)
  #
  #       ;; Set dired-x global variables here.  For example:
  #       (setq dired-x-hands-off-my-keys nil)
  #       (setq dired-omit-files "^\\.\\|~$")
  #
  #       ;; Set dired-aux global variables here.  For example:
  #       (setq dired-create-destination-dirs 'ask
  #             dired-vc-rename-file t)
  #
  #       ;; Set dired-plus global variables here.  For example:
  #       ;; (diredp-global-breadcrumbs-in-header-line-mode 1)
  #       )
  #     (add-hook 'dired-mode-hook
  #               (lambda ()
  #                 ;; Set dired-x buffer-local variables here.  For example:
  #                 (dired-omit-mode 1)
  #                 ))
  #
  #     ;; (use-package diredfl
  #     ;;   :hook (dired-mode . diredfl-mode)
  #     ;;   :hook (dirvish-directory-view-mode . diredfl-mode)
  #     ;;   )
  #
  #     ;;; diredfl.el --- Extra font lock rules for a more colourful dired  -*- lexical-binding: t; -*-
  #
  #     ;; Copyright (C) 2017  Steve Purcell
  #
  #     ;; Author: Steve Purcell <steve@sanityinc.com>
  #     ;; Author: Drew Adams
  #     ;; Keywords: faces
  #     ;; URL: https://github.com/purcell/diredfl
  #     ;; Package-Requires: ((emacs "24"))
  #     ;; Package-Version: 0.5
  #
  #     ;; This program is free software; you can redistribute it and/or modify
  #     ;; it under the terms of the GNU General Public License as published by
  #     ;; the Free Software Foundation, either version 3 of the License, or
  #     ;; (at your option) any later version.
  #
  #     ;; This program is distributed in the hope that it will be useful,
  #     ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
  #     ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  #     ;; GNU General Public License for more details.
  #
  #     ;; You should have received a copy of the GNU General Public License
  #     ;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
  #
  #     ;;; Commentary:
  #
  #     ;; This is adapted from the extra font lock rules provided by Drew
  #     ;; Adams' `dired+' package, but published via a modern means, and with
  #     ;; support for older Emacsen removed.
  #
  #     ;; Enable in all Dired buffers by calling or customising `diredfl-global-mode'.
  #
  #     ;; Alternatively:
  #
  #     ;;     (add-hook 'dired-mode-hook 'diredfl-mode)
  #
  #     ;;; Code:
  #
  #     (require 'dired)
  #
  #     (defgroup diredfl ()
  #       "Extra font lock rules for a more colourful Dired."
  #       :group 'dired)
  #
  #     (defcustom diredfl-compressed-extensions '(".tar" ".taz" ".tgz" ".arj" ".lzh"
  #                                                ".lzma" ".xz" ".zip" ".z" ".Z" ".gz" ".bz2")
  #       "*List of compressed-file extensions, for highlighting."
  #       :type '(repeat string) :group 'diredfl)
  #
  #     (defcustom diredfl-ignore-compressed-flag t
  #       "*Non-nil means to font-lock names of compressed files as ignored files.
  #     This applies to filenames whose extensions are in
  #     `diredfl-compressed-extensions'.  If nil they are highlighted using
  #     face `diredfl-compressed-file-name'."
  #       :type 'boolean :group 'diredfl)
  #
  #     (defface diredfl-autofile-name
  #       '((((background dark)) (:background "#111313F03181")) ; Very dark blue
  #         (t                   (:background "#EEECEC0FCE7E"))) ; Very pale goldenrod
  #       "*Face used in Dired for names of files that are autofile bookmarks."
  #       :group 'diredfl)
  #     (defvar diredfl-autofile-name 'diredfl-autofile-name)
  #
  #     (defface diredfl-compressed-file-name
  #       '((((background dark)) (:foreground "Blue"))
  #         (t                   (:foreground "Brown")))
  #       "*Face used for compressed file names."
  #       :group 'diredfl)
  #     (defvar diredfl-compressed-file-name 'diredfl-compressed-file-name)
  #
  #     (defface diredfl-compressed-file-suffix
  #       '((((background dark)) (:foreground "Blue"))
  #         (t                   (:foreground "Yellow")))
  #       "*Face used for compressed file suffixes in Dired buffers.
  #     This means the `.' plus the file extension.  Example: `.zip'."
  #       :group 'diredfl)
  #     (defvar diredfl-compressed-file-suffix 'diredfl-compressed-file-suffix)
  #
  #     (defface diredfl-date-time '((t :inherit font-lock-variable-name-face))
  #                                             ; '((((background dark)) (:foreground "#74749A9AF7F7")) ; ~ med blue
  #                                             ;   (t                   (:foreground font-lock-variable-name-face)))
  #       "*Face used for date and time in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-date-time 'diredfl-date-time)
  #
  #     (defface diredfl-deletion
  #       '((t (:foreground "Yellow" :background "Red")))
  #       "*Face used for deletion flags (D) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-deletion 'diredfl-deletion)
  #
  #     (defface diredfl-deletion-file-name
  #       '((t (:foreground "Red")))
  #       "*Face used for names of deleted files in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-deletion-file-name 'diredfl-deletion-file-name)
  #
  #     (defface diredfl-dir-heading
  #       '((((background dark)) (:foreground "Yellow" :background "#00003F3F3434")) ; ~ dark green
  #         (t                   (:foreground "Blue" :background "Pink")))
  #       "*Face used for directory headings in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-dir-heading 'diredfl-dir-heading)
  #
  #     (defface diredfl-dir-name
  #       '((((background dark))
  #          (:foreground "#7474FFFFFFFF" :background "#2C2C2C2C2C2C")) ; ~ cyan, dark gray
  #         (t (:foreground "DarkRed" :background "LightGray")))
  #       "*Face used for directory names."
  #       :group 'diredfl)
  #     (defvar diredfl-dir-name 'diredfl-dir-name)
  #
  #     (defface diredfl-dir-priv
  #       '((((background dark))
  #          (:foreground "#7474FFFFFFFF" :background "#2C2C2C2C2C2C")) ; ~ cyan, dark gray
  #         (t (:foreground "DarkRed" :background "LightGray")))
  #       "*Face used for directory privilege indicator (d) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-dir-priv 'diredfl-dir-priv)
  #
  #     (defface diredfl-exec-priv
  #       '((((background dark)) (:background "#4F4F3B3B2121")) ; ~ dark brown
  #         (t                   (:background "LightSteelBlue")))
  #       "*Face used for execute privilege indicator (x) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-exec-priv 'diredfl-exec-priv)
  #
  #     ;; For this to show up, you need `F' among the options in `dired-listing-switches'.
  #     ;; For example, I use "-alF" for `dired-listing-switches'.
  #     (defface diredfl-executable-tag
  #       '((t (:foreground "Green")))
  #       "*Face used for executable tag (*) on file names in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-executable-tag 'diredfl-executable-tag)
  #
  #     (defface diredfl-file-name
  #       '((((background dark)) (:foreground "Yellow"))
  #         (t                   (:foreground "Blue")))
  #       "*Face used for file names (without suffixes) in Dired buffers.
  #     This means the base name.  It does not include the `.'."
  #       :group 'diredfl)
  #     (defvar diredfl-file-name 'diredfl-file-name)
  #
  #     (defface diredfl-file-suffix
  #       '((((background dark)) (:foreground "#7474FFFF7474")) ; ~ light green
  #         (t                   (:foreground "DarkMagenta")))
  #       "*Face used for file suffixes in Dired buffers.
  #     This means the `.' plus the file extension.  Example: `.elc'."
  #       :group 'diredfl)
  #     (defvar diredfl-file-suffix 'diredfl-file-suffix)
  #
  #     (defface diredfl-flag-mark
  #       '((((background dark)) (:foreground "Blue" :background "#7575D4D41D1D")) ; ~ olive green
  #         (t                   (:foreground "Yellow" :background "Blueviolet")))
  #       "*Face used for flags and marks (except D) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-flag-mark 'diredfl-flag-mark)
  #
  #     (defface diredfl-flag-mark-line
  #       '((((background dark)) (:background "#787831311414")) ; ~ dark red brown
  #         (t                   (:background "Skyblue")))
  #       "*Face used for flagged and marked lines in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-flag-mark-line 'diredfl-flag-mark-line)
  #
  #     (defface diredfl-ignored-file-name
  #       '(;; (((background dark)) (:foreground "#FFFF921F921F")) ; ~ salmon
  #         ;; (((background dark)) (:foreground "#A71F5F645F64")) ; ~ dark salmon
  #         (((background dark)) (:foreground "#C29D6F156F15")) ; ~ salmon
  #         (t                   (:foreground "#00006DE06DE0")))                  ; ~ dark cyan
  #       "*Face used for ignored file names  in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-ignored-file-name 'diredfl-ignored-file-name)
  #
  #     (defface diredfl-link-priv
  #       '((((background dark)) (:foreground "#00007373FFFF")) ; ~ blue
  #         (t                   (:foreground "DarkOrange")))
  #       "*Face used for link privilege indicator (l) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-link-priv 'diredfl-link-priv)
  #
  #     (defface diredfl-no-priv
  #       '((((background dark)) (:background "#2C2C2C2C2C2C")) ; ~ dark gray
  #         (t                   (:background "LightGray")))
  #       "*Face used for no privilege indicator (-) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-no-priv 'diredfl-no-priv)
  #
  #     (defface diredfl-number
  #       '((((background dark)) (:foreground "#FFFFFFFF7474")) ; ~ light yellow
  #         (t                   (:foreground "DarkBlue")))
  #       "*Face used for numerical fields in Dired buffers.
  #     In particular, inode number, number of hard links, and file size."
  #       :group 'diredfl)
  #     (defvar diredfl-number 'diredfl-number)
  #
  #     (defface diredfl-other-priv
  #       '((((background dark)) (:background "#111117175555")) ; ~ dark blue
  #         (t                   (:background "PaleGoldenrod")))
  #       "*Face used for l,s,S,t,T privilege indicators in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-other-priv 'diredfl-other-priv)
  #
  #     (defface diredfl-rare-priv
  #       '((((background dark)) (:foreground "Green" :background "#FFFF00008080")) ; ~ hot pink
  #         (t                   (:foreground "Magenta" :background "SpringGreen")))
  #       "*Face used for rare privilege indicators (b,c,s,m,p,S) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-rare-priv 'diredfl-rare-priv)
  #
  #     (defface diredfl-read-priv
  #       '((((background dark)) (:background "#999932325555")) ; ~ burgundy / dark magenta
  #         (t                   (:background "MediumAquamarine")))
  #       "*Face used for read privilege indicator (w) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-read-priv 'diredfl-read-priv)
  #
  #     (defface diredfl-symlink
  #       '((((background dark)) (:foreground "#00007373FFFF")) ; ~ blue
  #         (t                   (:foreground "DarkOrange")))
  #       "*Face used for symbolic links in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-symlink 'diredfl-symlink)
  #
  #     (defface diredfl-tagged-autofile-name
  #       '((((background dark)) (:background "#328C0411328C")) ; Very dark magenta
  #         (t                   (:background "#CD73FBEECD73"))) ; Very pale green
  #       "*Face used in Dired for names of files that are autofile bookmarks."
  #       :group 'diredfl)
  #     (defvar diredfl-tagged-autofile-name 'diredfl-tagged-autofile-name)
  #
  #     (defface diredfl-write-priv
  #       '((((background dark)) (:background "#25258F8F2929")) ; ~ dark green
  #         (t                   (:background "Orchid")))
  #       "*Face used for write privilege indicator (w) in Dired buffers."
  #       :group 'diredfl)
  #     (defvar diredfl-write-priv 'diredfl-write-priv)
  #
  #     (defun diredfl-match-ignored-extensions (limit)
  #       "A matcher of ignored filename extensions for use in `font-lock-keywords'.
  #     LIMIT is the extent of the search."
  #       (let ((ignored-extensions
  #              (append (if (boundp 'dired-omit-extensions)
  #                          dired-omit-extensions
  #                        completion-ignored-extensions)
  #                      (when diredfl-ignore-compressed-flag
  #                        diredfl-compressed-extensions))))
  #         (when ignored-extensions
  #           (re-search-forward
  #            (concat "^  \\(.*"
  #                    (regexp-opt ignored-extensions)
  #                    ;; Optional executable flag
  #                    "[*]?\\)$")
  #            limit
  #            t))))
  #
  #     ;;; Define second level of fontifying.
  #     (defconst diredfl-font-lock-keywords-1
  #       (list
  #        '("^  \\(.+:\\)$" 1 diredfl-dir-heading) ; Directory headers
  #        '("^  wildcard.*$" 0 'default) ; Override others, e.g. `l' for `diredfl-other-priv'.
  #        '("^  (No match).*$" 0 'default) ; Override others, e.g. `t' for `diredfl-other-priv'.
  #        '("[^ .]\\(\\.[^. /]+\\)$" 1 diredfl-file-suffix) ; Suffix, including `.'.
  #        '("\\([^ ]+\\) -> .+$" 1 diredfl-symlink)         ; Symbolic links
  #
  #        ;; 1) Date/time and 2) filename w/o suffix.
  #        ;;    This is a bear, and it is fragile - Emacs can change `dired-move-to-filename-regexp'.
  #        `(,directory-listing-before-filename-regexp
  #          ;; (7 diredfl-date-time t t) ; Date/time, locale (western or eastern)
  #          ;; (2 diredfl-date-time t t) ; Date/time, ISO
  #          (7 font-lock-variable-name-face t t)
  #          (2 font-lock-variable-name-face t t)
  #          (,(concat "\\(.+\\)\\(" (concat (funcall #'regexp-opt diredfl-compressed-extensions)
  #                                          "\\)[*]?$"))
  #           nil nil (0 diredfl-compressed-file-name keep t))
  #          ) ; Compressed-file suffix
  #        `(,directory-listing-before-filename-regexp
  #          ;; (7 diredfl-date-time t t) ; Date/time, locale (western or eastern)
  #          ;; (2 diredfl-date-time t t) ; Date/time, ISO
  #          (7 font-lock-variable-name-face t t)
  #          (2 font-lock-variable-name-face t t)
  #          ;; ("\\(.+\\)$" nil nil (0 diredfl-file-name keep t))
  #          ) ; Filename (not a compressed file)
  #
  #        ;; Files to ignore
  #        '(diredfl-match-ignored-extensions 1 diredfl-ignored-file-name t)
  #
  #        ;; Compressed-file (suffix)
  #        (list (concat "\\(" (concat (funcall #'regexp-opt diredfl-compressed-extensions) "\\)[*]?$"))
  #              1 diredfl-compressed-file-suffix t)
  #        ;; '("\\([*]\\)$" 1 diredfl-executable-tag t) ; Executable (*)
  #        ;; '("^\\(.+\\)\\*$" 1 diredfl-executable-tag t)
  #        '("^\\(.+\\*\\)$" 1 'font-lock-string-face t) ; include * as well
  #        ;; '("\\([*]\\)$" 1 diredfl-executable-tag t) ; Executable (*)
  #        ;; (list (concat "^" dired-re-maybe-mark dired-re-inode-size
  #        ;;               ".*\\([^ \n]+\\*\\)$")
  #        ;;       '(1 diredfl-executable-tag t)) ; Executable (*)
  #
  #        ;; Inode, hard-links, & file size (. and , are for the decimal point, depending on locale)
  #        ;; See comment for `directory-listing-before-filename-regexp' in `files.el' or `files+.el'.
  #        ;; '("\\_<\\(\\([0-9]+\\([.,][0-9]+\\)?\\)[BkKMGTPEZY]?[ /]?\\)" 1 'diredfl-number)
  #        ;; (list (concat dired-re-maybe-mark dired-re-inode-size
  #        ;;               "\\([0-9]+\\([.,][0-9]+\\)?[BkKMGTPEZY]?\\)")
  #        ;;       '(1 diredfl-number))
  #        ;; (list (concat "\\_<\\([0-9]+\\([.,][0-9]+\\)?\\)[BkKMGTPEZY]?[ /]?")
  #        ;;       '(1 diredfl-number))
  #
  #        ;; Directory names - exclude d:/..., Windows drive letter in a dir heading.
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "\\(d\\)[^:]")
  #              '(1 diredfl-dir-priv t) '(".+" (dired-move-to-filename) nil (0 diredfl-dir-name t)))
  #
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]........\\(x\\)") ; o x
  #              '(1 diredfl-exec-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]........\\([lsStT]\\)") ; o misc
  #              '(1 diredfl-other-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].......\\(w\\).") ; o w
  #              '(1 diredfl-write-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]......\\(r\\)..") ; o r
  #              '(1 diredfl-read-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].....\\(x\\)...") ; g x
  #              '(1 diredfl-exec-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].....\\([lsStT]\\)...") ; g misc
  #              '(1 diredfl-other-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]....\\(w\\)....") ; g w
  #              '(1 diredfl-write-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]...\\(r\\).....") ; g r
  #              '(1 diredfl-read-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]..\\(x\\)...") ; u x
  #              '(1 diredfl-exec-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]..\\([lsStT]\\)...") ; u misc
  #              '(1 diredfl-other-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].\\(w\\)....") ; u w
  #              '(1 diredfl-write-priv))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]\\(r\\).....") ; u r
  #              '(1 diredfl-read-priv))
  #
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]........\\([-rwxlsStT]\\)") ; o -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].......\\([-rwxlsStT]\\).") ; g -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]......\\([-rwxlsStT]\\)..") ; u -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].....\\([-rwxlsStT]\\)...") ; o -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]....\\([-rwxlsStT]\\)....") ; g -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]...\\([-rwxlsStT]\\).....") ; u -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]..\\([-rwxlsStT]\\)......") ; o -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps].\\([-rwxlsStT]\\).......") ; g -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "[-bcdlps]\\([-rwxlsStT]\\)........") ; u -
  #              '(1 diredfl-no-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "\\(-\\)")
  #              '(1 diredfl-no-priv keep))
  #
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "\\([bcsmpS]\\)") ; (rare)
  #              '(1 diredfl-rare-priv keep))
  #        (list (concat dired-re-maybe-mark dired-re-inode-size "\\(l\\)[-rwxlsStT]") ; l
  #              '(1 diredfl-link-priv keep))
  #
  #        (list (concat "^\\([^\n " (char-to-string dired-del-marker) "].*$\\)")
  #              '(1 diredfl-flag-mark-line prepend))                          ; Flag/mark lines
  #        (list (concat "^\\([^\n " (char-to-string dired-del-marker) "]\\)") ; Flags, marks (except D)
  #              '(1 diredfl-flag-mark prepend))
  #
  #        (list (concat "^\\([" (char-to-string dired-del-marker) "].*$\\)") ; Deletion-flagged lines
  #              '(1 diredfl-deletion-file-name prepend))
  #        (list (concat "^\\([" (char-to-string dired-del-marker) "]\\)") ; Deletion flags (D)
  #              '(1 diredfl-deletion prepend)))
  #       "2nd level of Dired highlighting.  See `font-lock-maximum-decoration'.")
  #
  #
  #     ;;;###autoload
  #     (define-minor-mode diredfl-mode
  #       "Enable additional font locking in `dired-mode'."
  #       :global nil
  #       (setq font-lock-defaults
  #             (if diredfl-mode
  #                 '((dired-font-lock-keywords
  #                    dired-font-lock-keywords
  #                    diredfl-font-lock-keywords-1)
  #                   t nil nil beginning-of-line)
  #               '(dired-font-lock-keywords t nil nil beginning-of-line)))
  #       (font-lock-refresh-defaults))
  #
  #     ;;;###autoload
  #     (define-globalized-minor-mode diredfl-global-mode diredfl-mode
  #       (lambda ()
  #         (when (derived-mode-p 'dired-mode)
  #           (diredfl-mode)))
  #       :require 'diredfl)
  #
  #
  #     (provide 'diredfl)
  #     ;;; diredfl.el ends here
  #     ;; ----
  #
  #     ;; (use-package dired-rainbow
  #     ;;   :config
  #     ;;   (progn
  #     ;;     (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  #     ;;     (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  #     ;;     (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  #     ;;     (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  #     ;;     (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  #     ;;     (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  #     ;;     (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  #     ;;     (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  #     ;;     (dired-rainbow-define log "#c17d11" ("log"))
  #     ;;     (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  #     ;;     (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  #     ;;     (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  #     ;;     (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  #     ;;     (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  #     ;;     (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  #     ;;     (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  #     ;;     (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  #     ;;     (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  #     ;;     (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  #     ;;     (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
  #     ;;     )
  #     ;;   )
  #
  #     ;; dired plus spec for using denote dired mode
  #     ;; ---
  #     ;; (add-hook 'dired-mode-hook
  #     ;;           (lambda ()
  #     ;;             (setq-local font-lock-defaults
  #     ;;                         '((dired-font-lock-keywords)))
  #     ;;             (font-lock-refresh-defaults)))
  #
  #     ;; (add-hook 'dired-mode-hook #'denote-dired-mode t)
  #     ;; ---
  #
  #
  #     ;; (defface my-dired-document-face
  #     ;;   '((t :foreground "cyan"))
  #     ;;   "")
  #
  #     ;; (defface my-dired-audio-face
  #     ;;   '((t :foreground "green"))
  #     ;;   "")
  #
  #     ;; (with-eval-after-load 'dired
  #     ;;   (setq dired-font-lock-keywords
  #     ;;         (append
  #     ;;          dired-font-lock-keywords
  #     ;;          '(("\\.\\(jpg\\|jpeg\\|png\\|gif\\|webp\\|svg\\|bmp\\|tiff\\)\\>"
  #     ;;             0 'font-lock-regexp-grouping-backslash)
  #     ;;            ("\\.\\(mp4\\|mkv\\|webm\\|avi\\|mov\\|wmv\\|m4v\\)\\>"
  #     ;;             0 'font-lock-regexp-grouping-construct)
  #     ;;            ("\\.\\(pdf\\|doc\\|docx\\|odt\\|rtf\\|txt\\|epub\\|djvu\\)\\>"
  #     ;;             0 'my-dired-document-face)
  #     ;;            ("\\.\\(sh\\|desktop\\|vcf\\|py\\)\\>"
  #     ;;             0 'success)
  #     ;;            ("\\.\\(mp3\\|flac\\|opus\\|ogg\\|wav\\|m4a\\|aac\\)\\>"
  #     ;;             0 'my-dired-audio-face)))))
  #
  #     ;; (with-eval-after-load 'dired
  #     ;;   (setq dired-font-lock-keywords
  #     ;;         (append
  #     ;;          dired-font-lock-keywords
  #     ;;          '(
  #
  #     ;;            ;; ## is required.
  #     ;;            ;; Once ## exists, match each section up to the next delimiter.
  #     ;;            ("\\(##\\)\\([^@=\\n]*\\(?:[@=][^@=\\n]\\)*?\\)\\(@@\\|==\\|--\\|__\\)"
  #     ;;             (1 'font-lock-comment-face)
  #     ;;             (2 'error)
  #     ;;             (3 'font-lock-comment-face))
  #
  #     ;;            ;; Remaining sections.
  #     ;;            ("\\(@@\\|==\\|--\\|__\\)\\([^\\n]*?\\)\\(?=@@\\|==\\|--\\|__\\|\\.\\)"
  #     ;;             (1 'font-lock-comment-face)
  #     ;;             (2 'error))
  #
  #     ;;            ))))
  #
  #
  #     ;; (defun denote-faces-artists-matcher (limit)
  #     ;;   "Match artists in a filename, not looking beyond LIMIT."
  #     ;;   (let ((initial-match-data (match-data))
  #     ;;         (initial-point (point)))
  #     ;;     (if (or (re-search-forward "##\\(?1:[^/]*?\\)\\(@@\\|==\\|--\\|__\\|\\.\\)[^/]*$" limit t)
  #     ;;             (re-search-forward "##\\(?1:[^/]*\\)$" limit t))
  #     ;;         (progn
  #     ;;           (goto-char (match-end 1))
  #     ;;           (set-match-data (list (match-beginning 1) (match-end 1)))
  #     ;;           (point))
  #     ;;       (goto-char initial-point)
  #     ;;       (set-match-data initial-match-data)
  #     ;;       nil)))
  #
  #     ;; (defface my-denote-artists-face
  #     ;;   '((t :foreground "red" :weight bold))
  #     ;;   "Face for artists in Denote filenames.")
  #
  #     ;; (add-hook 'dired-mode-hook
  #     ;;           (lambda ()
  #     ;;             (font-lock-add-keywords
  #     ;;              nil
  #     ;;              '((denote-faces-artists-matcher
  #     ;;                 (0 'my-denote-artists-face nil t)))
  #     ;;              'append)
  #     ;;             (font-lock-flush)
  #     ;;             (font-lock-ensure))
  #     ;;           100)
  #
  #     ;; (add-hook 'dired-mode-hook
  #     ;;           (lambda ()
  #     ;;             (font-lock-add-keywords
  #     ;;              nil
  #     ;;              '(("##"
  #     ;;                 0 'denote-faces-delimiter nil))
  #     ;;              'append)
  #     ;;             (font-lock-flush)
  #     ;;             (font-lock-ensure))
  #     ;;           100)
  #
  #
  #     ;; (use-package dired-quick-sort
  #     ;;   :demand t
  #     ;;   :config
  #     ;;   (dired-quick-sort-setup)
  #     ;;   )
  #
  #
  #     ;; (with-eval-after-load 'dired
  #     ;;   (use-package dired+
  #     ;;     :vc (:url "https://github.com/emacsmirror/dired-plus" :rev :newest)
  #     ;;     :demand t
  #     ;;     )
  #     ;;   )
  #
  #     ;; do not use dirvish it is only added for dirvish-move for all intents and purposes
  #     (use-package dirvish
  #       :init
  #       (dirvish-override-dired-mode)
  #       :config
  #       (setq dirvish-default-layout '(0 0.6 0.4))
  #       (setq dirvish-reuse-session 'open)
  #       (setq dirvish-hide-details '(dired dirvish dirvish-side)
  #             dirvish-hide-cursor '(dirvish dirvish-side))
  #       (setq dirvish-mode-line-height 20
  #             dirvish-header-line-height 20)
  #       (setq dirvish-use-header-line nil)      ; hide header line (show the classic dired header)
  #       (setq dirvish-use-mode-line 'global)     ; make header line span all panes
  #
  #       (setq dirvish-preview-disabled-exts
  #             '("doc" "docx" "xls" "xlsx" "ppt" "pptx" "odt" "ods" "odp" "kbdx")
  #             )
  #
  #       ;; Segments
  #       (setq dirvish-header-line-format
  #             '(:left (path) :right (free-space))
  #             dirvish-mode-line-format
  #             '(:left (sort file-time " " file-size symlink) :right (omit yank index)))
  #
  #       (setq dirvish-attributes
  #             (append
  #              '(vc-state)
  #              ;; Other attributes are displayed in the order they appear in this list.
  #              '(git-msg file-time file-size)))
  #
  #       :custom
  #       (dirvish-quick-access-entries
  #        '(("h" "~/"                          "Home")
  #          ("d" "~/Downloads/"                "Downloads")
  #          ("D" "~/Documents/"                "Documents")
  #          ("m" "~/Music/"                    "Music")
  #          )
  #        )
  #       )
  #
  #     ;; (dirvish-define-preview eza (file)
  #     ;;   "Use `eza' to generate directory preview."
  #     ;;   :require ("eza") ; tell Dirvish to check if we have the executable
  #     ;;   (when (file-directory-p file) ; we only interest in directories here
  #     ;;     `(shell . ("eza" "-al" "--no-quotes"
  #     ;;                "--git" "--git-repos-no-status" "--smart-group"
  #     ;;                "--show-symlinks" "--mounts"
  #     ;;                "--header" "--binary" "--sort=name"
  #     ;;                "--icons" "never", file))))
  #
  #     (dirvish-define-preview eza (file)
  #       "Use `eza' to generate directory preview."
  #       :require ("eza") ; tell Dirvish to check if we have the executable
  #       (when (file-directory-p file) ; we only interest in directories here
  #         `(shell . ("eza" "-al" "--no-quotes"
  #                    "--sort=name" "--no-filesize" "--no-user" "--no-time" "--no-permissions"
  #                    "--icons" "never", file))))
  #
  #     (push 'eza dirvish-preview-dispatchers)
  #
  #     ;; dirvish keybinds
  #     (with-eval-after-load 'dirvish
  #       (evil-define-key 'normal dirvish-mode-map
  #         (kbd "?")   'dirvish-dispatch
  #         (kbd "q")   'dirvish-quit
  #         (kbd "b")   'dirvish-quick-access
  #         (kbd "p")   'dirvish-yank
  #         (kbd "F")   'dirvish-layout-toggle
  #         (kbd "z")   'dirvish-history-jump
  #         (kbd "gh")  'dirvish-subtree-up
  #         (kbd "gl")  'dirvish-subtree-toggle
  #         (kbd "h")   'dired-up-directory
  #         (kbd "l")   'dired-find-file
  #         (kbd "ss")  'dirvish-symlink
  #         (kbd "sS")  'dirvish-relative-symlink
  #         (kbd "sh")  'dirvish-hardlink
  #         (kbd "yl")  'dirvish-copy-file-true-path
  #         (kbd "yn")  'dirvish-copy-file-name
  #         (kbd "yp")  'dirvish-copy-file-path
  #         (kbd "yr")  'dirvish-copy-remote-path
  #         (kbd "yy")  'dired-do-copy
  #         (kbd "TAB") 'dirvish-subtree-toggle
  #         (kbd "h") nil
  #         (kbd "l") nil
  #         (kbd "C-l") 'dired-filter-pop
  #         (kbd "f") nil
  #         (kbd "f") 'dired-filter-by-regexp
  #         (kbd ".") nil
  #         (kbd ".") 'dired-omit-mode
  #         (kbd ",") nil
  #         (kbd ",") 'dirvish-quicksort
  #         ;; from dired
  #         (kbd "SPC") nil
  #         ;; (kbd "<left>") 'dired-up-directory
  #         ;; (kbd "<right>") 'dired-find-file
  #         ;; (kbd "<up>") nil
  #         ;; (kbd "<down>") nil
  #         ;; (kbd "<up>") 'dired-previous-line
  #         ;; (kbd "<down>") 'dired-next-line
  #         (kbd "k") 'dired-do-kill-lines
  #         (kbd "C-r") 'dired-do-redisplay
  #         (kbd "<mouse-1>") 'dired-find-file
  #         (kbd "<mouse-2>") 'dired-mouse-find-file
  #         (kbd "^") nil
  #         (kbd "-") nil
  #         (kbd "m") 'my-dired-toggle-mark
  #         ;; (kbd "M") 'diredp-mark-region-files
  #         (kbd "u") nil
  #         (kbd "u") 'dired-unmark-all-marks
  #         (kbd "U") nil
  #         ;; (kbd "U") 'revert-buffer
  #         (kbd ";") nil
  #         (kbd "r") nil
  #         (kbd "r") 'dired-do-rename
  #         (kbd "R") nil
  #         (kbd "R") 'wdired-change-to-wdired-mode
  #         ;; (kbd "i") nil
  #         (kbd "a") nil
  #         (kbd ".") nil
  #         (kbd "gs") 'find-file
  #         (kbd ";c") 'emacspeak-dirvish-zoxide
  #         (kbd ";C") 'emacspeak-consult-zoxide
  #         (kbd ";n") 'dired-get-total-size
  #         (kbd "o") nil
  #         ))
  #
  #     ;; :ng "f"   #'dirvish-file-info-menu
  #     ;; :ng "S"   #'dirvish-quicksort
  #     ;; :gm [left]  #'dired-up-directory
  #     ;; :gm [right] #'dired-find-file
  #     ;; :m  "[h"  #'dirvish-history-go-backward
  #     ;; :m  "]h"  #'dirvish-history-go-forward
  #     ;; :m  "[e"  #'dirvish-emerge-next-group
  #     ;; :m  "]e"  #'dirvish-emerge-previous-group
  #
  #     ;; :ng "M-b" #'dirvish-history-go-backward
  #     ;; :ng "M-f" #'dirvish-history-go-forward
  #     ;; :ng "M-n" #'dirvish-narrow
  #     ;; :ng "M-m" #'dirvish-mark-menu
  #     ;; :ng "M-s" #'dirvish-setup-menu
  #     ;; :ng "M-e" #'dirvish-emerge-menu
  #
  #     ;; )
  #
  #     ;; denote.el --note taking
  #
  #     (defun my-dired-modes ()
  #       (diredfl-mode)
  #       (denote-dired-mode))
  #
  #     (use-package denote
  #       :demand t
  #       :hook
  #       ((text-mode . denote-fontify-links-mode)
  #        ;; (dired-mode . diredfl-mode)
  #        ;; (dired-mode . denote-dired-mode)
  #        (dired-mode . my-dired-modes)
  #        )
  #
  #       :config
  #       (setq denote-directory (expand-file-name "~/Documents/Notes/"))
  #       (setq denote-save-buffers nil)
  #       (setq denote-known-keywords '("emacs" "unix" "philosophy" "history" "school" "fleeting"))
  #       (setq denote-infer-keywords t)
  #       (setq denote-sort-keywords t)
  #       (setq denote-prompts '(title keywords))
  #       (setq denote-excluded-directories-regexp nil)
  #       (setq denote-keywords-to-not-infer-regexp nil)
  #       (setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))
  #       (setq denote-date-prompt-use-org-read-date t)
  #       (setq denote-file-type 'markdown-yaml)
  #       (denote-rename-buffer-mode 1)
  #       )
  #
  #     ;; denote keybinds
  #     (evil-define-key 'normal 'global
  #       (kbd "<leader>nn") 'denote
  #       (kbd "<leader>nd") 'denote-dired
  #       (kbd "<leader>ng") 'denote-grep
  #       (kbd "<leader>nr") 'denote-rename-file
  #       (kbd "<leader>nR") 'denote-rename-file-using-front-matter
  #       (kbd "<leader>nl") 'denote-link
  #       (kbd "<leader>nL") 'denote-add-links
  #       (kbd "<leader>nb") 'denote-backlinks
  #       (kbd "<leader>nqc") 'denote-query-contents-link
  #       (kbd "<leader>nqf") 'denote-query-filenames-link
  #       )
  #     ;; denote dired keybinds
  #     (evil-define-key 'normal dired-mode-map
  #       (kbd "<leader>di") 'denote-dired-link-marked-notes
  #       (kbd "<leader>dr") 'denote-dired-rename-files
  #       (kbd "<leader>dk") 'denote-dired-rename-marked-files-with-keywords
  #       (kbd "<leader>dR") 'denote-dired-rename-marked-files-using-front-matter)
  #
  #
  #
  #     (defun open-file-external (file)
  #       (interactive "f")
  #       (let* ((file (expand-file-name file))
  #              (ext (downcase (or (file-name-extension file) "")))
  #              (program
  #               (cl-loop for (extensions command) in '((("mpg" "mpeg" "mp3" "mp4"
  #                                                        "avi" "wmv" "wav" "mov" "flv"
  #                                                        "ogm" "ogg" "mkv" "webm")
  #                                                       "mpv")
  #                                                      (("xbm" "pbm" "pgm" "ppm"
  #                                                        "pnm" "png" "gif" "bmp"
  #                                                        "tif" "jpeg" "jpg" "webp"
  #                                                        "heic")
  #                                                       "qview")
  #                                                      (("doc" "docx" "xls" "xlsx"
  #                                                        "ppt" "odt" "ods" "odg"
  #                                                        "odp")
  #                                                       "libreoffice")
  #                                                      (("pdf" "ps" "dvi")
  #                                                       "sioyek"))
  #                        when (member ext extensions)
  #                        return command)))
  #         (let ((process-connection-type nil))
  #           (start-process
  #            "open-file-external"
  #            nil
  #            (or program "xdg-open")
  #            file))))
  #
  #     (use-package openwith
  #       :demand t
  #       :straight
  #       (openwith
  #        :local-repo "~/.config/emacs/lisp/openwith"
  #        :type git)
  #       :config
  #       (setq openwith-associations
  #             (openwith/make-assocs
  #              '((("mpg" "mpeg" "mp3" "mp4"
  #                  "avi" "wmv" "wav" "mov" "flv"
  #                  "ogm" "ogg" "mkv" "webm")
  #                 "mpv" (file))
  #                (("xbm" "pbm" "pgm" "ppm"
  #                  "pnm" "png" "gif" "bmp"
  #                  "tif" "jpeg" "jpg" "webp"
  #                  "heic")
  #                 "qview"
  #                 (file))
  #                (("doc" "docx" "xls" "xlsx"
  #                  "ppt" "odt" "ods" "odg"
  #                  "odp")
  #                 "libreoffice" (file))
  #                (("7z"
  #                  "tar" "gz" "rar" "xz"
  #                  "zip")
  #                 "ark" (file))
  #                (("pdf" "ps" "ps.gz" "dvi")
  #                 "sioyek" (file)))))
  #       :init
  #       (openwith-mode t))
  #
  #
  #     ;; custom pickers and what not
  #     ;; --------------------------------------------------------------------------------------------------------
  #
  #     (defun emacspeak-dired-zoxide (q)
  #       "Query zoxide  and launch dired.
  #           Shell Utility zoxide --- implemented in Rust --- lets you jump to
  #           directories that are used often.
  #           This command does for Emacs, what zoxide does at the  shell."
  #       (interactive "sZoxide:")
  #       (if-let
  #           ((zoxide (executable-find "zoxide"))
  #            (target
  #             (with-temp-buffer
  #               (if (= 0 (call-process zoxide nil t nil "query" q))
  #                   (string-trim (buffer-string))))))
  #           (funcall-interactively #'dired  target)
  #         (unless zoxide (error "Install zoxide"))
  #         (unless target (error "No Match"))))
  #
  #     (defun emacspeak-dirvish-zoxide (q)
  #       "Query zoxide  and launch dirvish.
  #           Shell Utility zoxide --- implemented in Rust --- lets you jump to
  #           directories that are used often.
  #           This command does for Emacs, what zoxide does at the  shell."
  #       (interactive "sZoxide:")
  #       (if-let
  #           ((zoxide (executable-find "zoxide"))
  #            (target
  #             (with-temp-buffer
  #               (if (= 0 (call-process zoxide nil t nil "query" q))
  #                   (string-trim (buffer-string))))))
  #           (funcall-interactively #'dirvish  target)
  #         (unless zoxide (error "Install zoxide"))
  #         (unless target (error "No Match"))))
  #
  #
  #     (defun emacspeak-fzf-zoxide (q)
  #       "Query zoxide  and launch fzf.
  #           Shell Utility zoxide --- implemented in Rust --- lets you jump to
  #           directories that are used often.
  #           This command does for Emacs, what zoxide does at the  shell."
  #       (interactive "sZoxide:")
  #       (if-let
  #           ((zoxide (executable-find "zoxide"))
  #            (target
  #             (with-temp-buffer
  #               (if (= 0 (call-process zoxide nil t nil "query" q))
  #                   (string-trim (buffer-string))))))
  #           ;; (funcall-interactively #'fzf-find-file  target)
  #           (let ((default-directory (file-name-as-directory target)))
  #             (call-interactively #'fzf-find-file))
  #         (unless zoxide (error "Install zoxide"))
  #         (unless target (error "No Match"))))
  #
  #     (defun emacspeak-consult-zoxide (q)
  #       "Query zoxide  and launch fzf.
  #           Shell Utility zoxide --- implemented in Rust --- lets you jump to
  #           directories that are used often.
  #           This command does for Emacs, what zoxide does at the  shell."
  #       (interactive "sZoxide:")
  #       (if-let
  #           ((zoxide (executable-find "zoxide"))
  #            (target
  #             (with-temp-buffer
  #               (if (= 0 (call-process zoxide nil t nil "query" q))
  #                   (string-trim (buffer-string))))))
  #           ;; (funcall-interactively #'consult-fd  target)
  #           (let ((default-directory (file-name-as-directory target)))
  #             (call-interactively #'my-consult-fd))
  #         (unless zoxide (error "Install zoxide"))
  #         (unless target (error "No Match"))))
  #
  #
  #     (defun string-quoted-p (str)
  #       (or
  #        (and (string-prefix-p "\"" str) (string-suffix-p "\"" str))
  #        (and (string-prefix-p "'" str) (string-suffix-p "'" str))))
  #
  #     (defun consult-zoxide ()
  #       (interactive)
  #       (let ((target
  #              (consult--read
  #               (consult--process-collection
  #                   (lambda (x) (append
  #                                '("zoxide" "query" "-l")
  #                                (if (string-quoted-p x) (list x)
  #                                  (split-string x)))))
  #               :prompt "Zoxide "
  #               :require-match nil
  #               :lookup #'consult--lookup-member
  #               ;; :require-match t
  #               :category 'file
  #               :sort nil
  #               )))
  #         (if target
  #             (let ((default-directory (concat target "/")))
  #               (call-interactively 'my-consult-fd))
  #           (call-interactively 'my-consult-fd))))
  #
  #     (defun my-consult-fd ()
  #       (interactive)
  #       (let ((files
  #              (process-lines "fd" "--type" "file")))
  #         (when files
  #           (let ((file
  #                  (consult--read
  #                   files
  #                   :prompt "Find file: "
  #                   :category 'file
  #                   ;; :sort nil
  #                   :require-match t)))
  #             (when file
  #               (find-file file))))))
  #
  #     ;; (defun fzf-zoxide ()
  #     ;;   (interactive)
  #     ;;   (let ((target
  #     ;;          (consult--read
  #     ;;           (consult--process-collection
  #     ;;               (lambda (x) (append
  #     ;;                            '("zoxide" "query" "-l")
  #     ;;                            (if (string-quoted-p x) (list x)
  #     ;;                              (split-string x)))))
  #     ;;           :prompt "Zoxide:  "
  #     ;;           :require-match nil
  #     ;;           :lookup #'consult--lookup-member
  #     ;;           :require-match t
  #     ;;           :category 'file
  #     ;;           :sort nil)))
  #     ;;     (if target
  #     ;;         (let ((default-directory (concat target "/")))
  #     ;;           (call-interactively 'fzf))
  #     ;;       (call-interactively 'fzf))))
  #     ;; ------
  #
  #
  #
  #     (defun my/diff-auto-save-file ()
  #       "Get auto-save #file# difference with current buffer."
  #       (interactive)
  #       (diff (make-auto-save-file-name) (current-buffer) nil 'noasync))
  #
  #     (defun auto-save-file-remove ()
  #       "Delete auto-save #file# if exist."
  #       (interactive)
  #       (let ((filename (make-auto-save-file-name)))
  #         (if (not (file-exists-p filename))
  #             (message (concat "File " filename " don't exist"))
  #           ;; else
  #           (delete-file filename nil) ; no trash
  #           (message (concat "File " filename " succesfully removed."))
  #           )))
  #
  #     (setq make-backup-files nil)
  #
  #
  #     ;; (defun my-denote-slug-hyphenate (string)
  #     ;;   "Replace spaces and underscores with hyphens in STRING.
  #     ;; Also replace multiple hyphens with a single one and remove
  #     ;; leading and trailing hyphens."
  #     ;;   (setq string (replace-regexp-in-string "[[:space:]_]+" "-" string))
  #     ;;   (setq string (replace-regexp-in-string "-\\{2,\\}" "-" string))
  #     ;;   (setq string (replace-regexp-in-string "\\`-\\|-\\'" "" string))
  #     ;;   string)
  #
  #     ;; (defun my-dired-denote-slug-hyphenate ()
  #     ;;   "Rename marked Dired files using `my-denote-slug-hyphenate`."
  #     ;;   (interactive)
  #     ;;   (dired-map-over-marks
  #     ;;    (let* ((old-name (dired-get-filename))
  #     ;;           (file-name (file-name-nondirectory old-name))
  #     ;;           (new-name (my-denote-slug-hyphenate file-name)))
  #     ;;      (unless (equal file-name new-name)
  #     ;;        (dired-rename-file old-name
  #     ;;                           (expand-file-name new-name
  #     ;;                                             (file-name-directory old-name))
  #     ;;                           nil)))
  #     ;;    nil))
  #
  #     ;; (evil-define-key 'normal dired-mode-map
  #     ;;   (kbd "<leader>dh") #'my-dired-denote-slug-hyphenate)
  #
  #
  #     ;; file type mode
  #     (use-package markdown-mode
  #       :mode ("README\\.md\\'" . gfm-mode)
  #       :init
  #       (setq markdown-command "multimarkdown"
  #             markdown-gfm-additional-languages '("sh")
  #             markdown-make-gfm-checkboxes-buttons t
  #             markdown-fontify-whole-heading-line t
  #             markdown-fontify-code-blocks-natively t
  #             markdown-mouse-follow-link nil
  #             )
  #       :custom
  #       (add-to-list 'major-mode-remap-alist '(markdown-mode . gfm-mode))
  #       )
  #     (use-package haskell-mode
  #       :mode ("\\.hs\\'")
  #       :init
  #       (setq haskell-process-suggest-remove-import-lines t  ; warnings for redundant imports etc
  #             haskell-process-auto-import-loaded-modules t
  #             )
  #       )
  #     (use-package nix-mode
  #       :mode ("\\.nix\\'")
  #       )
  #
  #
  #     (use-package kdeconnect
  #       :demand t
  #       :config
  #       (setq kdeconnect-devices '(("Redmi Note 12 Pro + 5G" . "3ba0cca3bccf4a9fa485bfaaa0f55c97")
  #                                  ))
  #       (setq kdeconnect-active-device '("Redmi Note 12 Pro + 5G" . "3ba0cca3bccf4a9fa485bfaaa0f55c97")
  #             )
  #       )
  #
  #     (put 'dired-find-alternate-file 'disabled nil)
  #
  #
  #
  #     (use-package magit)
  #     (use-package vi-tilde-fringe)
  #   '';
  # };

  home.packages = with pkgs; [
    # emacs-gtk
    # nixfmt
    # vterm etc
    cmake
    gcc
    libtool
    # req
    graphviz
    plantuml
    # lsp
    # marksman
    # nixd
    # lua-language-server
    # texlab
    zotero
    # poppler-utils
    # vips
    # (aspellWithDicts (
    #   dicts:
    #     with dicts; [
    #       en
    #       en-computers
    #       en-science
    #       tr
    #     ]
    # ))
  ];
}
