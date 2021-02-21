;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package :lisp-stat)

;;;; Types and functions that extend those of Alexandria, commonly
;;;; used in statistics and probability

(deftype probability () 
  "A number between 0 and 1"
  `(real 0 1))

(deftype percentage () 
  "A number between 0 and 100"
  `(real 0 100))

;;; From Papp cl-random/random.lisp
(declaim (inline check-probability))
(defun check-probability (p &optional open)
  "Assert that P is a probability (ie a real number between 0 and 1).  When OPEN is given, it is checked that p is not 0 (:LEFT), 1 (:RIGHT), or 0/1 (:BOTH)."
  #+sbcl (declare (sb-ext:muffle-conditions sb-ext:code-deletion-note)) ;; implementation-specific functions
  (assert (<= 0 p 1) () "~A is not a valid probability." p)
  (when open
    (let ((msg "The given probability is only attained in the limit."))
      (ecase open
        (:both (assert (/= p 0 1) () msg))
        (:left (assert (/= p 0) () msg))
        (:right (assert (/= p 1) () msg)))))
  t)
