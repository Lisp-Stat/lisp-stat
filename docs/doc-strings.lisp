;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.
(in-package :lisp-stat)

;;; Add doc-strings where the implementation lacks them

#+sbcl
(progn
  (setf (documentation 'pi 'variable) "PI                                                              [variable-doc]
The floating-point number that is approximately equal to the ratio of the circumference of a circle to its diameter.")
  (setf (documentation 'complex 'type) "COMPLEX                                                             [type-doc]
    A complex number")
  ) ; progn
