;;; init.el --- My Emacs Initialization/Customization file  -*- lexical-binding: t -*-

;;; Comments
;;; These settings are portable at unix based operating system then dont expect it works at windows base systems(32/64bits)

;; GNU | Melpa | NonGNU packages set config
(require 'package)

(setq package-archives
      '(("gnu". "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.gnu.org/packages/")
	("nongnu" . "https://elpa.nongnu/nongnu/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
 (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;;disable the transient mark mode
(setq kill-whole-line t)
(setq select-active-regions nil)

;;kbd for windows 
(bind-key "A-M-n" 'enlarge-window)
(bind-key "A-M-p" 'shrink-window)
(bind-key "A-M-f" 'enlarge-window-horizontally)
(bind-key "A-M-b" 'shrink-window-horizontally)

;;comments C-c 
(bind-key "C-c ;" 'comment-region)

;;set my fav black-white (modus-vivendi) by @protosilaes
(use-package modus-themes
  :ensure t
  :demand t
  :init
  (setq modus-themes-to-toggle '(modus-vivendi)
        modus-themes-to-rotate '(modus-vivendi)
        modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-completions '((t . (bold)))
        modus-themes-prompts '(bold)
        modus-themes-headings
        '((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15))))
  :config
  (load-theme 'modus-vivendi t))
  
  (use-package rainbow-delimiters)
  
  (setq modus-themes-common-palette-overrides nil)
  
(modus-themes-load-theme 'modus-vivendi)

;display hour/day at minibuffer m/d h:s
  (setq display-time-day-and-date t)
  (set-variable 'display-time-24hr-format t)
  (set-variable 'display-time-string-forms
              '(month "/" day
                      " " 24-hours ":" minutes ;; ":" seconds
                      (if mail " Mail" "")))

;;my main settings of 'dired-' commands                                    
(use-package dired
    :ensure nil
    :defer t
    :config
    (setq dired-auto-revert-buffer t    ; Revert on re-visiting
        ;; Better dired flags: `-l' is mandatory ,`-a' shows all files ,`-h
        ;; using a  human-readable sizes, and `-F' append filetype classifiers
        ;; to file names (for better highlighting)
        dired-listing-switches "-alhF"
        dired-ls-F-marks-symlinks t   ; -F marks links with @
        ;; allow prompts for simple recursive operations
        dired-recursive-copies 'always
        ;; auto-copy to other dired split window
        dired-dwim-target t)

    (when (or (memq system-type '(gnu gnu/linux))
              (string= (file-name-nondirectory insert-directory-program) "gls"))))

    ;; unix system ls 
    ;; `--group-directories-first' lists directories before files
          (concat dired-listing-switches " --group-directories-first -v")

 (require 'multiple-cursors)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this) 
  (global-set-key (kbd "C-<") 'mc/mark-pr%evious-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

   (progn
  ;; improve performance of emacs : 
    (setopt bidi-paragraph-direction 'left-to-right) ;;just set it if you dont right left-to-right langs(ex:arabic)
    (setopt bidi-display-reordering 'left-to-right)
    (setopt bidi-inhibit-bpa t)
    (setopt redisplay-skip-fontification-on-input t);;skip the redisplay fontify because it causes micro stutters at large buffer
    (setopt read-process-output-max (* 4 1024 1024)) ;;the default of emacs is usually 64kb that is a lotta of conservative then im setting 4mb it reduces the numbers of emacs calls of read for system that emacs need to do   

   (setopt window-combination-resize t))
    (display-time)
   (blink-cursor-mode 0)
					; my font IBM plex mono
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;removing 'delete-other-window' and adding winner-mode (C-x 1)
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)

;;That's interesting tool for develop regexps
;;(setq reb-re-syntax 'string)

;;help(just for fix the kbd 'C-xo' broke press)
;;(setq help-window-select t) 
;;(setopt isearch-lazy-count t)

;;^^deprecated code idk how to fix this

;;iSearch settings

(setq isearch-allow-motion t
      isearch-motion-changes-direction t)

;;LOADING SETTINGS OF 
;;'c-mode'

(use-package cc-mode
  :ensure nil
  :config
(setq c-default-style "k&r")

(define-advice c-indent-new-comment-line
    (:after(&rest_arg) smart-extended-commands)
  (when (and
         (looking-at (rx (zero-or-more (not-char ?/n)) "/"))
                     (not (looking-at (rx (zero-or-more (not-char ?\n)) "/*"))))
         (save-excursion
           (re-search-forward (rx "*/") (line-end-position))
           (forward-char -2)
           (newline)
           (indent-according-to-model))))

(defun c-or-c++-header ()
  "Sets either c-mode or c++-mode, whichever is appropriate."
  (interactive)
  (let ((c-file (concat (file-name-sans-extension
                         (buffer-file-name))
                        ".c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))



