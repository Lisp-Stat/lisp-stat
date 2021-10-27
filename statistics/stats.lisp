;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
(in-package #:lisp-stat)

(defun interquartile-range (x)
  "Returns the interquartile range of the elements of X."
  (reduce #'- (nu:quantiles x '(0.75 0.25))))

(defun fivenum (x &key (tukey nil))
  "By default, returns the five number summary (min, 1st quartile, median, 3rd quartile, max) of the elements X.
   If the keyword :tukey is set to a non-nil value, Tukey's fivenum summary is computed instead."
   (if tukey
     (let+ ((#(mn md mx) (nu:quantiles x '(0 0.5 1)))
	    (sorted (sorted-reals-elements (nu:ensure-sorted-reals x)))
	    (l (length sorted))
	    (left (subseq sorted 0 (floor (/ (1+ l) 2))))
	    (right (subseq sorted (floor (/ l 2)) l))
	    (hinge-left (nu:median left))
	    (hinge-right (nu:median right)))
        (vector mn hinge-left md hinge-right mx))

       (nu:quantiles x '(0 0.25 0.5 0.75 1))))
