;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:lisp-stat)

;;; Logical pathname setup

;; Logical pathnames are not well supported in CCL. For example the
;; backquote macro cannot be used in the *.pathname-translations
;; files, as demonstrated in the (setup-ls-translations) below, so
;; they must be hard-coded there. It is for that reason that I created
;; these functions, with the intention that the user can call it after
;; LS starts, or place in their init file.

(defun setup-ls-translations ()
  (setf (logical-pathname-translations "ls")
	`(("DATASETS;**;*.*.*" ,(merge-pathnames "datasets/**/*.*" (asdf:system-source-directory 'lisp-stat)))
	  ("CACHE;**;*.*.*"    ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-cache-home)))
	  ("DATA;**;*.*.*"     ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-data-home)))
	  ("CONFIG;**;*.*.*"   ,(merge-pathnames "lisp-stat/**/*.*" (uiop:xdg-config-home))))))

(setup-ls-translations)

;;; Library versioning

;; As Lisp-Stat evolves over time, you may feel the need to
;; conditionalise your code based on the version of the library.
;; Application level versioning follows the Semantic Versioning
;; guidelines (https://semver.org/) and is implemented with CL-SEMVER
;; (https://github.com/cldm/cl-semver).  With this you can query
;; major, minor and patch versions of the library.
;; E.g. (cl-semver:print-version-to-string ls:*version*)

(defparameter *ls-version* (cl-semver:read-version-from-string "0.0.1")) ; Will not change until first release
(defparameter *release-name* nil)	; Will be nil until the first release


;;; Printer control variables
(setf *print-pretty* nil)
(setf *print-lines* 25)

;; Load user init file, if present
(if (probe-file #P"~/ls-init.lisp")
    (load #P"~/ls-init.lisp"))

