;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf usarrests (read-csv rdata:usarrests)
  "Violent Crime Rates by US State

Description
This data set contains statistics, in arrests per 100,000 residents,
for assault, murder, and rape in each of the 50 US states in 1973.
Also given is the percent of the population living in urban areas.

Note
USArrests contains the data as in McNeil's monograph. For the UrbanPop
percentages, a review of the table (No. 21) in the Statistical
Abstracts 1975 reveals a transcription error for Maryland (and that
McNeil used the same “round to even” rule that R's round() uses), as
found by Daniel S Coven (Arizona).

See the example below on how to correct the error and improve accuracy
for the ‘<n>.5’ percentages.

Source
World Almanac and Book of facts 1975. (Crime rates).
Statistical Abstracts of the United States 1975, p.20, (Urban rates),
possibly available as
https://books.google.ch/books?id=zl9qAAAAMAAJ&pg=PA20.

References
McNeil, D. R. (1977) Interactive Data Analysis. New York: Wiley.

Examples

(summary usarrests)

;; Difference between 'USArrests' and its correction
(which usarrests:x3 :predicate (lambda (x) (string= \"Maryland\" x))) ; #(19)
(select usarrests 19 'urbanpop)         ; 67, the value transcribed incorrectly
(setf (elt usarrests:urbanpop 19) 76.6) ; change to the correct value

;; correct rounding errors of +/- 0.5 to restore the original  <n>.5 percentages
(map nil (lambda (x)
	   (setf (elt usarrests:urbanpop x)
		 (+ 0.5 (elt usarrests:urbanpop x))))
     (which usarrests:x3 :predicate (lambda (x)
				      (or (string= \"Colorado\" x)
					  (string= \"Florida\" x)
					  (string= \"Mississippi\" x)
					  (string= \"Wyoming\" x)))))

(map nil (lambda (x)
	   (setf (elt usarrests:urbanpop x)
		 (- 0.5 (elt usarrests:urbanpop x))))
     (which usarrests:x3 :predicate (lambda (x)
				      (or (string= \"Nebraska\" x)
					  (string= \"Pennsylvania\" x)))))")

(set-properties usarrests :label '(:murder   "Murder arrests, per 100,000 population"
				   :assault  "Assault arrests, per 100,000 population"
				   :urbanpop "Percentage of urban population"
				   :rape     "Rape arrests, per 100,000 population"))
usarrests

