;; view-mode
(custom-set-variables
 '(view-read-only t))

(defun View-goto-line-last (&optional line)
  "goto last line"
  (interactive "P")
  (goto-line (line-number-at-pos (point-max))))

(eval-after-load "view"
  '(progn
     ;; less like
     (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
     (define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
     (define-key view-mode-map (kbd "g") 'View-goto-line)
     (define-key view-mode-map (kbd "G") 'View-goto-line-last)
     (define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
     (define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
     ;; vi/w3m like
     (define-key view-mode-map (kbd "h") 'backward-char)
     (define-key view-mode-map (kbd "j") 'next-line)
     (define-key view-mode-map (kbd "k") 'previous-line)
     (define-key view-mode-map (kbd "l") 'forward-char)
     (define-key view-mode-map (kbd "[") 'backward-paragraph)
     (define-key view-mode-map (kbd "]") 'forward-paragraph)
     (define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
     (define-key view-mode-map (kbd "K") 'View-scroll-line-backward)))

(eval-after-load "doc-view"
  '(progn
     (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
     (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)))
