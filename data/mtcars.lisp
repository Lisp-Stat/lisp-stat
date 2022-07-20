;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf mtcars (read-csv rdata:mtcars)
  "Motor Trend Car Road Tests

Description
The data was extracted from the 1974 Motor Trend US magazine, and
comprises fuel consumption and 10 aspects of automobile design and
performance for 32 automobiles (1973–74 models).

Note
Henderson and Velleman (1981) comment in a footnote to Table 1:
‘Hocking [original transcriber]'s noncrucial coding of the Mazda's
rotary engine as a straight six-cylinder engine and the Porsche's flat
engine as a V engine, as well as the inclusion of the diesel Mercedes
240D, have been retained to enable direct comparisons to be made with
previous analyses.’

Source
Henderson and Velleman (1981), Building multiple regression models
interactively. Biometrics, 37, 391–411.")


;; The column with car models is blank, i.e. a row name, and the
;; system fills it in with a generated name.  Since we don't know at
;; this point what name was given, we have to get it by position.
(rename-column! mtcars 'model (first-elt (keys mtcars)))

(set-properties mtcars :label '(:mpg  "Miles/(US) gallon"
				:cyl  "Number of cylinders"
				:disp "Displacement (cu.in.)"
				:hp   "Gross horsepower"
				:drat "Rear axle ratio"
				:wt   "Weight (1000 lbs)"
				:qsec "1/4 mile time"
				:vs   "Engine (0=v-shaped, 1=straight)"
				:am   "Transmission (0=automatic, 1=manual)"
				:gear "Number of forward gears"
				:carb "Number of carburetors"))

(set-properties mtcars :unit '(:mpg  m/g
			       :cyl  :NA
			       :disp in³
			       :hp   hp
			       :drat :NA
			       :wt   lb
			       :qsec s
			       :vs   :NA
			       :am   :NA
			       :gear :NA
			       :carb :NA))

(heuristicate-types mtcars)

;; Categorical variables cannot be automatically determined
(set-properties mtcars :type '(:vs :categorical
			       :am :categorical
			       :gear :categorical
			       :carb :categorical))

