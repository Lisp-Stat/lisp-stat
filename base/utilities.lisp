;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:lisp-stat)

;;; Utility functions. For developers, not users, thus not exported.


;;; Convenience Functions

;; See:
;;    https://github.com/avodonosov/local-package-aliases
;;    https://stackoverflow.com/questions/28906563/alias-package-names-in-common-lisp
;; (defun add-nickname (package nickname)
;;   "Rename a long package name to something shorter."
;;   (when (stringp package)
;;     (setf package (find-package package)))
;;   (check-type package package)
;;   (check-type nickname string)
;;   (rename-package package (package-name package)
;;                   (adjoin nickname (package-nicknames package)
;;                           :test #'string-)))

