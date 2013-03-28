;;;; helm
(require 'helm-config)
(require 'helm-descbinds)
(require 'helm-myutils)

;; helm-ag
(eval-after-load "helm-ag"
  '(progn
     (setq helm-ag-insert-at-point 'symbol)))

;; configuration helm variable
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 500)
(helm-descbinds-install)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)
(global-set-key (kbd "C-;") 'helm-myutils:git-project)
(global-set-key (kbd "<f10>") 'helm-myutils:dropbox)
(global-set-key (kbd "C-M-s") 'helm-ag-this-file)

(remove-hook 'kill-emacs-hook 'helm-adaptive-save-history)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "white" :background nil :underline t)

(set-face-attribute 'helm-source-header nil
                    :height 1.0)
