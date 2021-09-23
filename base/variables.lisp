;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
;;; Copyright (c) 2009 by AJ Rossini

(in-package #:lisp-stat)

;;;; Listing and Saving Variables and Functions

(defvar *variables* nil)
(defvar *ask-on-redefine* nil)

(defmacro def (name value &optional (documentation nil documentation-p))
  "Define a data variable
VALUE is not evaluated and must be a symbol.  Assigns the value of FORM to VALUE and adds VALUE to the list *VARIABLES* of def'ed variables. Returns VALUE.  If VALUE is already bound and the global variable *ASK-ON-REDEFINE* is not nil then you are asked if you want to redefine the variable."
  `(progn (declaim (special ,name))
	  (unless (and *ask-on-redefine*
		       (boundp ',name)
		       (not (y-or-n-p "Variable has a value. Redefine?")))
	    ,(when documentation-p
		   `(setf (documentation ',name 'variable) ',documentation))
	    (setf (symbol-value ',name) ,value)
	    (pushnew ',name *variables*))
	  ',name))


(defun undef-var (v)
"Remove V from the system
If V is the symbol of a defined variable the variable it is unbound and removed from the list of defined variables. If V is a list of variable names each is unbound and removed. Returns V.
Example: (undef 'urban)"
  (dolist (s (if (listp v) v (list v)))
          (when (member s *variables*)
                (setf *variables* (delete s *variables*))
                (makunbound s)))
  v)

(defun variables ()
"Returns a list of the names of all def'ed variables."
  (sort (copy-list *variables*) #'string<=))

(defgeneric save-obj (data)
  (:documentation "Save data object"))

(defun savevar (vars file &optional (suffix ".lisp"))
  "VARS is a symbol or a list of symbols.  FILE is a string (or a symbol whose print name is used) not ending in SUFFIX (defaults to \".lisp\"). The VARS and their current values are written to the file FILE.lisp in a form suitable for use with the load command.  NOTE: Ensure VARS doesn't contain CLOS objects that don't have a SAVE-OBJ method.
Example (savevar 'urban \"urban\")"
  (let ((filename (concatenate 'string (namestring file) suffix)))
    (when (or (not (probe-file filename))
	      (y-or-n-p "File ~S exits. Overwrite?" filename))
      (with-open-file (f filename :direction :output)
	(let ((vars (if (consp vars) vars (list vars))))
	  (flet ((save-one (x)
		   (let ((v (symbol-value x)))
		     (if (typep v 'standard-object)
			 (format f "(def ~s ~s)~%" x (save-obj v))
			 (format f "(def ~s '~s)~%" x v)))))
	    (mapcar #'save-one vars))
	  vars)))))
