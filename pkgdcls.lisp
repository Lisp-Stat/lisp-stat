;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: CL-USER -*-
;;; Copyright (c) 2021-2022 by Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package #:lisp-stat
  (:documentation "Base functions for Lisp-Stat")
  (:use :common-lisp)

  (:import-from :let-plus #:let+)

  ;; Fix symbol conflicts
  ;; This would be easier with something like defpackage-plus, but that system is somewhat fragile when redefining packages
  (:shadowing-import-from :statistics-1 #:mean #:variance #:median) ; alexandria only works on sequences
;; (:shadowing-import-from :lh.statistics #:square)
  (:shadowing-import-from :array-operations     #:flatten)                  ; alexandria works on cons trees, aops on arrays
  ;; (:shadowing-import-from :distributions        #:standard-deviation)       ; alexandria only works on sequences

  (:use-reexport :alexandria
		 :alexandria+
		 :array-operations
		 :data-frame
                 :dfio
		 :num-utils.arithmetic
                 :num-utils.elementwise
                 :num-utils.utilities
		 :num-utils.print-matrix
		 :select
		 :split-sequence
		 :statistics-1)
  (:export #:variables
           #:def
	   #:undef-var
           #:savevar
	   #:load-tutorial-data))

