;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021-2022 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:lisp-stat)

;;; Logical pathname setup

;; Logical pathnames are not well supported in CCL. For example the
;; backquote macro cannot be used in the *.pathname-translations
;; files, as demonstrated in the (setup-ls-translations) below, so
;; they must be hard-coded there. It is for that reason that I created
;; these functions, with the intention that the user can call it after
;; LS starts, or place in their init file.

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

(uiop:define-package #:ls-user
  (:documentation "User package for Lisp-Stat")
  (:use :common-lisp :lisp-stat)
  (:import-from :rdata #:get-r-data))

