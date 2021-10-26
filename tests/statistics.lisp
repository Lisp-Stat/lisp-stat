;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: LS-TESTS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:ls-tests)

(defun run-tests (&key (report 'parachute:plain) (test 'all))
    (let ((*package* #.*package*))
      (parachute:test (etypecase test
                        (symbol test)
                        (string (find-symbol test *package*)))
                      :report report)))

(define-test all)

(define-test statistics
  :parent all)

(define-test interquartile-range
  :parent statistics
  (is = 5.5 (interquartile-range #(8 2 3 9 5 1 4 10 7 0 6))) ;vector
  (is = 5.5 (interquartile-range '(8 2 3 9 5 1 4 10 7 0 6))) ;list
  (fail (interquartile-range '(8 2 3 9 5 1 4 10 7 0 A))))    ;type error

(define-test fivenum
  ;; Test results obtained from https://www.icalcu.com/stat/fivenum.html
  :parent statistics
  (is nu:num= #(1 2.25 4 5.75 7) (fivenum '(1 2 3 4 5 6 7)))
  (is nu:num= #(1 2.5 4.5 6.5 8) (fivenum '(1 2 3 4 5 6 7 8)))
  (is nu:num= #(1 2.5 4.5 6.5 8) (fivenum #(1 2 3 4 5 6 7 8)))
  (is nu:num= #(2 5 8 8 15) (fivenum #(2 5 8 8 15) :tukey t))
  (is nu:num= #(2 5 10 15 18) (fivenum #(2 5 8 12 15 18) :tukey t))
  (fail (fivenum '(8 2 3 9 5 1 4 10 7 0 A)))) ;type error with non-numeric value


