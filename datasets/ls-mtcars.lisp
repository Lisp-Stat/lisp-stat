;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-

(in-package #:ls-user)

(defdf mtcars (read-csv rdata:mtcars)
  "Motor Trend Car Road Tests")

;; The column with car models is blank, and the system fills it in
;; with a generated name. Since we don't know at this point what name
;; was given, we have to get it by position, thus the (symbol-name ...
;;(eval `(replace-key! mtcars model ,(symbol-name (aref (keys mtcars) 0))))
(eval `(replace-key! mtcars model ,(aref (keys mtcars) 0)))

(set-properties mtcars :label '(:mpg "Miles/(US) gallon"
				:cyl "Number of cylinders"
				:disp "Displacement (cu.in.)"
				:hp "Gross horsepower"
				:drat "Rear axle ratio"
				:wt "Weight (1000 lbs)"
				:qsec "1/4 mile time"
				:vs "Engine (0=v-shaped, 1=straight)"
				:am "Transmission (0=automatic, 1=manual)"
				:gear "Number of forward gears"
				:carb "Number of carburetors"))

(set-properties mtcars :unit '(:mpg m/g
			       :cyl :NA
			       :disp in³
			       :hp hp
			       :drat :NA
			       :wt lb
			       :qsec s
			       :vs :NA
			       :am :NA
			       :gear :NA
			       :carb :NA))

(heuristicate-types mtcars)



