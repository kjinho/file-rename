;;;; file-rename.lisp

(in-package #:file-rename)

(defun format-filename (str)
  (multiple-value-bind (orig split-string) (split-out-date-string str)
    (if (null orig)
        nil
        (format
         nil
         "~a-~a~a ~a"
         (aref split-string 0)
         (aref split-string 1)
         (aref split-string 2)
         (aref split-string 3)))))

(defun format-namestring (path)
  (let* ((filename (file-namestring path))
         (new-filename (format-filename filename)))
    (if (null new-filename)
        nil
        (merge-pathnames (pathname new-filename) path))))

(defun process-all-files (path-list)
  (loop for path in path-list
        do (let ((new-path (format-namestring path)))
             (unless (null new-path)
               (rename-file path new-path)))))

(defun take (n list)
  (loop :repeat n :for x :in list :collect x))

(defun drop (n list)
  (if (or (<= n 0) (null list))
      list
      (drop (1- n) (cdr list))))

(defun split-out-date-string (str)
  (let ((regex (ppcre:create-scanner "^(20[0-9][0-9])[\-_]?([0-9X][0-9X])[\-_]?([0-9X][0-9X])[ -_]?(.+)")))
    (ppcre:scan-to-strings regex str)))
