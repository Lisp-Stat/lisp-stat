;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(require :cl-date-time-parser)		;could also use chronicity

(defdf imdb (vega:read-vega vega:movies))

;; Transform the dates from mmm dd yyyy to timestamp
(replace-column! imdb 'release-date #'(lambda (x)
				       (local-time:universal-to-timestamp
					(date-time-parser:parse-date-time x))))


;; Categorical variables cannot be automatically determined
(set-properties imdb :type '(:release-date :temporal))
