;; Emacs lisp install file

;; first eval this code block
(add-to-list 'load-path "~/.emacs.d/elisps")

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar my/install-packages
  '(
    ;;;; for auto-complete
    auto-complete fuzzy popup ac-slime pos-tip

    ;;;; highlight
    ace-jump-mode vline col-highlight

    ;;;; editing utilities
    expand-region wrap-region
    undo-tree mark-multiple redo+ smartrep
    yasnipppet

    ;;;; buffer utils
    popwin elscreen yascroll

    ;;;; programming
    ;; haskell
    haskell-mode ghc ghci-completion

    ;; flymake
    flycheck flymake-jslint

    ;; coffee-script
    coffee-mode

    ;; ruby
    ruby-block ruby-compilation ruby-end ruby-interpolation
    ruby-mode ruby-test-mode ruby-tools inf-ruby
    yari

    ;; Common Lisp
    paredit

    ;; scala
    scala-mode

    ;; common utility
    quickrun

    ;;;; markup language
    haml-mode htmlize
    markdown-mode markdown-mode+
    scss-mode yaml-mode zencoding-mode

    ;; helm
    helm helm-gtags

    ;;;; misc
    logito
))

(package-refresh-contents)

(dolist (pack my/install-packages)
  (unless (package-installed-p pack)
    (package-install pack)))
