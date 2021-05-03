;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:lisp-stat)

;;;; Types and functions that extend those of Alexandria, commonly
;;;; used in statistics and probability

(deftype probability ()
  "A number between 0 and 1"
  `(real 0 1))

(deftype percentage ()
  "A number between 0 and 100"
  `(real 0 100))
