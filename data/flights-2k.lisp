;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(require :chronicity)

(defdf flights-2k (vega:read-vega vega:flights-2k))

(replace-column! flights-2k 'date #'(lambda (x)
				       (chronicity:parse x)))

;; Categorical variables cannot be automatically determined
(set-properties flights-2k :type '(:date :temporal))






