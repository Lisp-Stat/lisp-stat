;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(asdf:defsystem :lisp-stat
  :name "Lisp Statistics"
  :version     (:read-file-form "version.sexp")
  :description "A statistical computing environment for common lisp"
  :long-description "Common Lisp Statistics (LS): An environment for statistical computing"
  :author      "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:alexandria
	       #:array-operations
	       ;; #:cl-ppcre		; regular expressions; not required yet
	       #:cl-semver		; Application versioning
	       #:data-frame
	       #:dfio
	       #:distributions
	       #:num-utils
	       #:select
	       #:split-sequence)
  :in-order-to ((test-op (test-op lisp-stat/tests)))
  :components ((:file #:pkgdcls)
	       (:file #:ls-init)
	       (:static-file #:LICENSE)
	       (:module "base"
			:serial t
			:components
			((:file #:utilities)
			 (:file #:variables)))  ; XLS style variable definitions
	       (:module "docs"
		:components ((:file #:doc-strings)))))


(asdf:defsystem :lisp-stat/rdata
  :description "API for manipulating data sets from R packages"
  :long-description "Load Rdatasets from github into a data structure and provide access functions. See https://github.com/vincentarelbundock/Rdatasets/tree/master/csv"
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:cl-csv #:dexador #:make-hash #:cl-ascii-table #:dfio)
  :serial t
  :pathname "datasets/"
  :components ((:file #:rdata)))


(asdf:defsystem :lisp-stat/tests
  :description "Unit tests for Lisp-Stat"
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:lisp-stat #:parachute)
  :serial t
  :pathname "tests/"
  :components ((:file #:tstpkg)
	       (:file #:variables))
  :perform (test-op (o s)
  		    (uiop:symbol-call :parachute :test :ls-tests)))


