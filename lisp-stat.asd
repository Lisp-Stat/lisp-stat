;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: ASDF -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(defsystem :lisp-stat
  :name "Lisp Statistics"
  :version     (:read-file-form "version.sexp")
  :description "A statistical computing environment for Common Lisp"
  :author      "Steve Nunez <steve@symbolics.tech>"
  :license     :MS-PL
  :depends-on ("alexandria"
	       "array-operations"
	       "data-frame"
	       "dfio"
	       "num-utils"
	       "select"
	       #-genera "dexador"
	       "split-sequence")
  :in-order-to ((test-op (test-op lisp-stat/tests)))
  :components ((:file "pkgdcls")
	       (:static-file #:LICENSE)
	       (:module "base"
			:serial t
			:components
			((:file "variables") ;XLS style variable definitions
			 (:file "rdata")))   ;Utilities for working with R data sets
	       (:module "statistics"
		        :serial t
		        :components ((:file "stats")))
	       (:module "docs"
		:components ((:file "doc-strings")))
	       (:file "ls-init")))

(defsystem :lisp-stat/tests
  :description "Unit tests for Lisp-Stat"
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on ("lisp-stat" "parachute")
  :serial t
  :pathname "tests/"
  :components ((:file "tstpkg")
	       (:file "statistics"))
  :perform (test-op (o s)
  		    (symbol-call :ls-tests :run-tests)))
