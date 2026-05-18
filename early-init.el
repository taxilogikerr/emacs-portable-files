;;; early-init.el --- evaluated before init.el -*- lexical-binding: t -*-

(setq frame-resize-pixelwise t
      inhibit-splash-screen t
      inhibit-startup-screen t
      use-short-answers t
      inhibit-startup-buffer-menu t
      ring-bell-function 'ignore
      inhibit-startup-echo-area-message t
      )

(show-paren-mode 1)
(setq show-paren-style 'expression)
(setq show-paren-when-point-inside-paren t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
(setq ffap-machine-p-known 'reject)

(prefer-coding-system 'utf-8)

(setq frame-resize-pixelwise t
      inhibit-splash-screen t ;;disable the startup image screen
      inhibit-startup-screen t ;; disable the message of the screen
      use-short-answers t
      inhibit-startup-buffer-menu t
      ring-bell-function 'ignore
      inhibit-startup-echo-area-message t
      )

					;;;removing the polution of my UI/UX ;;(- 'menu-bar-mode') (- 'tool-bar-mode') (- 'scroll-bar-mode')

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist)
  (push '(ns-appearance . dark) default-frame-alist))


(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right
              buffer-file-coding-system 'utf-8
              indent-tabs-mode nil
              indicate-buffer-boundaries '((bottom . left)))



;; The lines settings

					;('relative-number-line-mode' t)
					;('display-global-relative-line' t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
(setq-default display-line-numbers-width 2)
(setq-default display-line-numbers-widen t)

(setq package-enable-at-startup nil)


