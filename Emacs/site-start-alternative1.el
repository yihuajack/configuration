; E:\Program_Files\Emacs\x86_64\share\emacs\site-lisp
(defun set-home-dir (dir)
  (setenv "HOME" dir)
  (message (format "HOME location is %s" (getenv "HOME"))))

(set-home-dir "D:/Documents/Programming/emacshome/")