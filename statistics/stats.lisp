;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
(in-package #:lisp-stat)

(defun interquartile-range (x)
  "Returns the interquartile range of the elements of X."
  (reduce #'- (nu:quantiles x '(0.75 0.25))))

(defun fivenum (x)
  "Returns the five number summary (min, 1st quartile, median, 3rd quartile, max) of the elements X.
Note this is not Tukey's fivenum summary, which R returns. The results will differ when X contains an even number of elements.
See:
   https://www.icalcu.com/stat/fivenum.html
   https://math.stackexchange.com/questions/398077/question-on-five-number-summary-quantile"
  (nu:quantiles x '(0 0.25 0.5 0.75 1)))
