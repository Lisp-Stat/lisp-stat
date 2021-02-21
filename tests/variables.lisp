;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS-TESTS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package :ls-tests)

(dolist (var (variables))		; Ensure a clean start
    (undef var))

(def water (list 31.5 27.0 25.9 39.1 39.2 38.3 33.9 33.8 27.9 33.1 26.3 37.8 34.6 36.4))
(def depth (vector 8.9 36.6 36.8 6.1 6.9 6.9 7.3 8.4 6.5 8.0 4.5 9.9 2.9 2.0))
(defvar w (list 31.5 27.0 25.9 39.1 39.2 38.3 33.9 33.8 27.9 33.1 26.3 37.8 34.6 36.4))

(define-test variables
  (true (and (subsetp w water) (subsetp water w))) ; Two lists contain the same elements iff they are subsets of each other
  (of-type list water)
  (of-type vector depth)
  (true (= 2 (length (variables))))
  (savevar '(water depth) #P"ls:datasets;saved-variables-test")
  (undef 'depth)
  (true (= 1 (length (variables))))
  (undef 'water)
  (true (= 0 (length (variables))))

  ;; Load saved variables from file and repeat tests
  (load  #P"ls:datasets;saved-variables-test")
  (delete-file #P"ls:datasets;saved-variables-test.lisp")
  (true (and (subsetp w water) (subsetp water w))) ; Two lists contain the same elements iff they are subsets of each other
  (of-type list water)
  (of-type vector depth)
  (true (= 2 (length (variables))))
  (undef 'depth)
  (true (= 1 (length (variables))))
  (undef 'water)
  (true (= 0 (length (variables)))))


