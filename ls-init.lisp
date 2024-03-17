;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LISP-STAT -*-
;;; Copyright (c) 2021-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:lisp-stat)

;;; Logical pathname setup

;; Logical pathnames are not well supported in CCL.  For example the
;; backquote macro cannot be used in the *.pathname-translations
;; files, as demonstrated in the (setup-ls-translations) below, so
;; they must be hard-coded there.  It is for that reason that I
;; created these functions, with the intention that the user can call
;; it after LS starts, or place in their init file.

(defun setup-ls-translations ()
  (setf (logical-pathname-translations "LS")
	`(("DATA;**;*.*.*"    ,(merge-pathnames "data/**/*.*" (asdf:system-source-directory 'lisp-stat)))
	  ("CACHE;**;*.*.*"   ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-cache-home)))
	  ;; ("DATA;**;*.*.*"     ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-data-home))) ;for individual users
	  ("CONFIG;**;*.*.*"  ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-config-home))))))

(setup-ls-translations)

;;; Printer control variables
(setf *print-pretty* nil)
(setf *print-lines* 25)

;; Use this in your personal ccl-init.lisp file to change package to LS-USER automatically
;; Modeled after CCL:SET-DEVELOPMENT-ENVIRONMENT
#+CCL
(defun set-lisp-stat-environment (&optional (thaw-definitions nil))
  "Arrange that the outermost special bindings of *PACKAGE* and
*WARN-IF-REDEFINE-KERNEL* restore values of the LS-USER package and
NIL respectively, and set *ccl-save-source-locations* to T. If the
optional argument is true, mark all globally defined functions and
methods as being not predefined (this is a fairly expensive
operation).  Use thaw-definitions you are redefining functions in CCL or CL packages."
  (when thaw-definitions
    (ccl::thaw-current-definitions))
  ;; enable redefine-kernel-function's error checking
  (ccl::%reset-outermost-binding '*warn-if-redefine-kernel* nil)
  ;; Set the top-level *package* to the LS-USER package
  (ccl::%reset-outermost-binding '*package* (find-package "LS-USER"))
  (setq ccl::*ccl-save-source-locations* T))

