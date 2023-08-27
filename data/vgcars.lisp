;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf vgcars (vega:read-vega vega:cars))

(set-properties vgcars :label '(:origin  "Country of origin"
				   :year  "Year of manufacture"
				   :displacement "Displacement (cu.in.)"
				   :horsepower   "Gross horsepower"
				   :cylinders "Number of cylinders"
				   :weight-in-lbs   "Weight in lbs"
				   :acceleration "1/4 mile time"
				   :miles-per-gallon "Miles per gallon"))

(set-properties vgcars :unit '(:miles-per-gallon  m/g
				  :cylinders    :NA
				  :displacement in³
				  :horsepower   hp
				  :weight-in-lb lb
				  :acceleration s))

(heuristicate-types vgcars)

;; Categorical variables cannot be automatically determined
(set-properties vgcars :type '(:origin  :categorical
				:year   :categorical
				:name   :categorical
				:cylinders :categorical))





