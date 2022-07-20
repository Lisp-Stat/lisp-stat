;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf disasters (read-csv vega:disasters))

(set-properties disasters :label '(:year  "Year of disaster"
				   :deaths "Number of deaths"))

;; This data set has a bare year value, e.g. '1900', that Vega-Lite
;; interprets as an integer.  Transform the column to an ISO-8601
;; format.
(replace-column! disasters 'year #'(lambda (x)
				     (local-time:encode-timestamp 0 0 0 0 1 1 x)))

;; Categorical variables cannot be automatically determined
(set-properties disasters :type '(:year   :temporal
				  :entity :categorical))





