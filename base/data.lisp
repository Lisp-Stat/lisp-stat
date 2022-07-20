;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LISP-STAT -*-
;;; Copyright (c) 2022 by Symbolics Pte. Ltd. All rights reserved.
(in-package #:lisp-stat)

;;; Consolidated data loading functions

;;; Utility for loading example data sets from Lisp-Stat, R and
;;; contributed packages.

(defun data (d &key (system "LS") (directory "DATA") (type "LISP"))
  "Load a data frame from a CSV or LISP data source located on the local filesystem named by D.  Intended for example data sets for Lisp-Stat system.  Parameters may be either a KEYWORD or STRING.  JSON files require application specific loaders, so not handled here.  Use (read-vega ...) for example.

Description
Each package using lisp-stat should define its own logical host, and a directory called DATA.  Once done, you can load  the example data sets like so:

LS-USER> (data my-example :system :glimpse)

If the system is named GLIMPSE.  To load a data set from R, assuming you have configured a logical host, RDATA:

LS-USER> (data :antigua :system :rdata :directory :daag :type :csv)"
  (let ((host (if (stringp system)
		  system
		  (symbol-name system))))
    (unless (stringp directory)
      (setf directory (symbol-name directory)))
    (unless (stringp d)
      (setf d (symbol-name d)))
    (unless (stringp type)
      (setf type (symbol-name type)))

    (switch (type :test #'equal)
      ("LISP" (load (make-pathname :host host
				   :directory directory
				   :name d
				   :type type)))
      ("CSV" (defdf d (read-csv (make-pathname :host host
					       :directory directory
					       :name d
					       :type type)))))))
