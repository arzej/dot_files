;; use cl functions and macros in my config files.
(require 'cl)

;; I use notification anywhere
(require 'notifications)

;; decide system is MacOSX
(defun macosx-p ()
  (eq system-type 'darwin))
