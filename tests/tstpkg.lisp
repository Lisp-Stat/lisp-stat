;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
(in-package :cl-user)

(uiop:define-package :ls-tests
  (:documentation "Tests for Lisp-Stat")
  (:use :common-lisp
	:lisp-stat
	:parachute)

  ;; Parachute has symbol conflicts with Alexandria and data-frame
  (:shadowing-import-from :parachute #:name)
  (:shadowing-import-from :parachute #:summary)
  (:shadowing-import-from :parachute #:featurep)
  (:shadowing-import-from :parachute #:of-type))

