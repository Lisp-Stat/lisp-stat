;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: RDATA -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package #:rdata
    (:use :common-lisp :make-hash)
  (:export #:packages
	   #:show-packages
	   #:show-package-items
	   #:rdata))

(in-package :rdata)

(defparameter packages nil "A-List of packages in the R datasets repository")
(defparameter index "https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/datasets.csv")

(defun cdr-assoc (item alist)
  "Return the value associated with ITEM in ALIST"
  (cdr (assoc item alist)))

#|
The data structure looks like this:

packages: an a-list of (pkg . items) conses
items is a hash-table:
    key: item
    value: hash-table of data

hash-table of data:
    title, n-rows, n-cols, n-binary, n-char, n-factor, n-logical, n-numeric, url, docs

package and item strings are converted to symbols using read-from-string.

At the moment, access to the nested values isn't too cumbersome. If it
becomes so, consider using the access library.
https://github.com/AccelerationNet/access

Note: items are not unique in the index, so we need to specify both
the package and item to load. |#

;;; Read RData index into the data structure
(eval-when (:load-toplevel)
  (iter:iter ;; cl-csv depends on iterate, so we'll use it here
    (iter:for (pkg item title n-rows n-cols n-binary n-char n-factor n-logical n-numeric url docs) in-csv (dex:get index) skipping-header t)
    (when (not (assoc (read-from-string pkg) packages))
      (setf packages (acons (read-from-string pkg) (make-hash-table) packages))
      (export (read-from-string pkg)))
    (let* ((current-item (cdr-assoc (read-from-string pkg) packages)))
      (setf (gethash (read-from-string item) current-item)
	    (make-hash :size 10
		       :initial-contents `(title     ,title
					   n-rows    ,(parse-integer n-rows)
					   n-cols    ,(parse-integer n-cols)
					   n-binary  ,(parse-integer n-binary)
					   n-char    ,(parse-integer n-char)
					   n-factor  ,(parse-integer n-factor)
					   n-logical ,(parse-integer n-logical)
					   n-numeric ,(parse-integer n-numeric)
					   url       ,url
					   docs      ,docs)))
      (export (read-from-string item)))))

;;; Access functions

(defun show-packages ()
  "Return a list of the Rdata packages"
  (iter:iter
    (iter:for pkg in packages)
    (iter:collect (car pkg))))

(defun show-package-items (package)
  "Display information on the datasets contained in PACKAGE
Example: (show-package-items 'aer)"
  (let* ((pkg (cdr-assoc package packages))
	 (table (ascii-table:make-table '("Dataset" "Title" "Vars." "Obs.") :header (symbol-name package))))
    (iter:iter
      (iter:for (item value) in-hashtable pkg)
      (ascii-table:add-row table `(,item ,(gethash 'title value) ,(gethash 'n-cols value) ,(gethash 'n-rows value))))
    (ascii-table:display table)))

(defun rdata (package item)
  "Return a CSV stream with the data from ITEM in PACKAGE
Examples:
    (rdata 'aer 'affairs) ; from within the rdata package
    (rdata 'rdata:aer 'rdata:affairs)"
  (let ((url (gethash 'url (gethash item (cdr-assoc package packages)))))
    (dex:get url :want-stream t)))
