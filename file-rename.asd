;;;; file-rename.asd

(asdf:defsystem #:file-rename
  :description "Describe file-rename here"
  :author "Jin-Ho King"
  :license  "MIT License"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-ppcre
               #:uiop)
  :components ((:file "package")
               (:file "file-rename")))
