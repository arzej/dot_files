;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)

;; helm binding
(global-set-key (kbd "C-M-z")   'helm-resume)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-h a")   'helm-c-apropos)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s")   'helm-occur)
(global-set-key (kbd "C-x b")   'helm-buffers-list)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(defun my/delete-line ()
  (interactive)
  (delete-region (line-beginning-position) (line-end-position)))
(define-key my/ctrl-q-map (kbd "k") 'my/delete-line)

(defun my/copy-line ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))
(define-key my/ctrl-q-map (kbd "l") 'my/copy-line)

;; paste
(defun repeat-yank (arg)
  (interactive "p")
  (dotimes (i arg)
    (yank)))
(define-key my/ctrl-q-map (kbd "p") 'repeat-yank)

;; col-highlight
(autoload 'col-highlight-mode "col-highlight" nil t)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)

(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'find-file-other-window)
(define-key my/ctrl-q-map (kbd "C-p") 'pomodoro:start)
(define-key my/ctrl-q-map (kbd "|") 'winner-undo)
(define-key my/ctrl-q-map (kbd "C-b") 'helm-bookmarks)

(defun swap-buffers ()
  (interactive)
  (when (one-window-p)
    (error "Frame is not splitted!!"))
  (let ((curwin (selected-window))
        (curbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer curwin (window-buffer))
    (set-window-buffer (selected-window) curbuf)))
(define-key my/ctrl-q-map (kbd "b") 'swap-buffers)

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

;; M-g mapping
(global-set-key (kbd "M-g .") 'helm-ack)
(global-set-key (kbd "M-g ,") 'helm-ack-pop-stack)
(global-set-key (kbd "M-g M-f") 'ffap)

;; duplicate current line
(defun duplicate-thing (n)
  (interactive "p")
  (save-excursion
    (let ((orig-line (line-number-at-pos))
          (str (if mark-active
                   (buffer-substring (region-beginning) (region-end))
                 (buffer-substring (line-beginning-position)
                                   (line-end-position)))))
      (forward-line 1)
      ;; maybe last line
      (when (= orig-line (line-number-at-pos))
        (insert "\n"))
      (dotimes (i (or n 1))
        (insert str "\n"))))
  (forward-line 1))

(smartrep-define-key
    global-map "M-g" '(("c" . duplicate-thing)))

;; flymake
(smartrep-define-key
    global-map "M-g" '(("M-n" . 'flymake-goto-next-error)
                       ("M-p" . 'flymake-goto-prev-error)))
