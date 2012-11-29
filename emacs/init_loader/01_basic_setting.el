;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; Coloring
(global-font-lock-mode t)

;; temp directory
(when (file-exists-p "/mnt/ramdisk")
  (setq temporary-file-directory "/mnt/ramdisk/"))

;; cursor
(when window-system
  (set-cursor-color "chartreuse2")
  (blink-cursor-mode t))

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)

;; large file
(setq large-file-warning-threshold (* 25 1024 1024))

;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)

;; saveplace
(savehist-mode 1)
(load "saveplace")
(setq-default save-place t)

;; savekill
(require 'savekill)

(setq dabbrev-case-fold-search nil)

;; info for japanese
(auto-compression-mode t)

;; highlight mark region
(transient-mark-mode t)

;; indicate last line
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

;; Disable default scroll bar and tool bar
(when window-system
  (set-scroll-bar-mode 'nil)
  (tool-bar-mode 0))

;; enable yascrollbar
(require 'yascroll)
(global-yascroll-bar-mode)

;; not create backup file
(setq backup-inhibited t)

;; not create auto save file
(setq delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

;; not beep
(setq ring-bell-function (lambda()))

;; not display start message
(setq inhibit-startup-message t)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

;; to send clip board
(setq x-select-enable-clipboard t)

;; ignore upper or lower
(setq read-file-name-completion-ignore-case t)

;; yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)

;; move physical line
(setq line-move-visual nil)

;; which-func
(require 'which-func)
(setq which-func-modes (append which-func-modes '(cperl-mode)))
(set-face-foreground 'which-func "chocolate4")
(set-face-bold-p 'which-func t)
(which-func-mode t)

;; invisible mouse cursor when editing text
(setq make-pointer-invisible t)

;; undo-tree
(require 'undo-tree)
(setq undo-tree-mode-lighter " UT")
(global-undo-tree-mode)

(define-key undo-tree-map (kbd "C-x u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-visualize)

;; fill-mode
(setq fill-column 80)

;; move to mark position
(setq set-mark-command-repeat-pop t)

;; fixed line position after scrollup, scrolldown
(defadvice scroll-up (around scroll-up-relative activate)
  "Scroll up relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

(defadvice scroll-down (around scroll-down-relative activate)
  "Scroll down relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

;; smart repetition
(require 'smartrep)

;; expand symbolic link
(setq-default find-file-visit-truename t)

;; for popular file type
(require 'generic-x)
