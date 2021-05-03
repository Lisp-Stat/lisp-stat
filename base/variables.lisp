;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: LS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
;;; Copyright (c) 1991 by Luke Tierney.

(in-package #:lisp-stat)

;;;; Listing and Saving Variables and Functions

(defvar *variables* nil) ; Will SBCL allow these to be updated?
(defvar *ask-on-redefine* nil)

;;; TODO: Fix the documentation string
(defmacro def (name value &optional (documentation nil documentation-p))
  "Args: (var form)
VAR is not evaluated and must be a symbol.  Assigns the value of FORM to
VAR and adds VAR to the list *VARIABLES* of def'ed variables. Returns VAR.
If VAR is already bound and the global variable *ASK-ON-REDEFINE*
is not nil then you are asked if you want to redefine the variable."
  `(progn (declaim (special ,name))
	  (unless (and *ask-on-redefine*
		       (boundp ',name)
		       (not (y-or-n-p "Variable has a value. Redefine?")))
	    ,(when documentation-p
		   `(setf (documentation ',name 'variable) ',documentation))
	    (setf (symbol-value ',name) ,value)
	    (pushnew ',name *variables*))
	  ',name))

;;; Example: (undef 'urban)
(defun undef (v)
"Args: (v)
If V is the symbol of a defined variable the variable it is unbound and
removed from the list of defined variables. If V is a list of variable
names each is unbound and removed. Returns V."
  (dolist (s (if (listp v) v (list v)))
          (when (member s *variables*)
                (setf *variables* (delete s *variables*))
                (makunbound s)))
  v)

(defun variables ()
"Args:()
Returns a list of the names of all def'ed variables."
  (sort (copy-list *variables*) #'string<=))

;;; TODO: Move this to the LS data object file when we start it.
;;; Only here to quiet the compiler when evaluating savevar below
(defgeneric save (data)
  (:documentation "Save the data."))

;;; Note that we change the predicate test in save-one from objectp to
;;; typep because we only deal with CLOS objects.
;;; See: http://www.cs.cmu.edu/Groups/AI/util/html/faqs/lang/lisp/part5/faq-doc-5.html
;;; Example usage: (savevar 'urban "urban")
(defun savevar (vars file &optional (suffix ".lisp"))
  "Args: (vars-symbol-or-list file-name-root &optional suffix-string)
NOTE: Ensure vars doesn't contain CLOS objects that don't have a save
method.  VARS is a symbol or a list of symbols. FILE-NAME-ROOT is a
string (or a symbol whose print name is used) not ending in
SUFFIX (defaults to \".lisp\"). The VARS and their current values are
written to the file FILE-NAME-ROOT.lisp in a form suitable for use with
the load command."

  (let ((filename (concatenate 'string (namestring file) suffix)))
    (when (or (not (probe-file filename))
	      (y-or-n-p "File ~S exits. Overwrite?" filename))
      (with-open-file (f filename :direction :output)
	(let ((vars (if (consp vars) vars (list vars))))
	  (flet ((save-one (x)
		   (let ((v (symbol-value x)))
		     (if (typep v 'standard-object)
			 (format f "(def ~s ~s)~%" x (save v))
			 (format f "(def ~s '~s)~%" x v)))))
	    (mapcar #'save-one vars))
	  vars)))))
