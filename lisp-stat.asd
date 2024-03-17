;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: ASDF -*-
;;; Copyright (c) 2021-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(defsystem "lisp-stat"
  :name "Lisp Statistics"
  :version     "1.4.0"
  :license     :MS-PL
  :author      "Steve Nunez <steve@symbolics.tech>"
  :long-name   "Statistical Computing in Common Lisp"
  :description "A statistical computing environment for Common Lisp"
  :long-description  #.(uiop:read-file-string
			(uiop:subpathname *load-pathname* "description.text"))
  :homepage    "https://lisp-stat.dev/"
  :source-control (:git "https://github.com/Lisp-Stat/lisp-stat.git")
  :bug-tracker "https://github.com/Lisp-Stat/lisp-stat/issues"

  :depends-on ("alexandria"
               "alexandria+"
	       "array-operations"
	       "data-frame"
	       "distributions"
	       #-genera "dexador"
	       "dfio"
	       "num-utils"
	       "select"
	       "statistics"
	       "org.tfeb.conduit-packages")
  :in-order-to ((test-op (test-op lisp-stat/tests)))
  :components ((:file "pkgdcls")
	       (:static-file #:LICENSE)
	       (:module "base"
			:serial t
			:components
			((:file "variables"))) ;XLS style variable definitions
	       (:module "docs"
		:components ((:file "doc-strings")))
	       (:file "ls-init")))

#+ignore
(defsystem :lisp-stat/tests ;most functionality has been moved to the individual systems
  :version "1.0.0"
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
