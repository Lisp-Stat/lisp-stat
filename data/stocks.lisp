;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf stocks (read-csv vega:stocks))

(set-properties stocks :label '(:symbol "SPX stock symbol"
				:price "Closing price"
				:date "Date"))

;; Categorical variables cannot be automatically determined
(set-properties stocks :type '(:date  :temporal
			       :price :single-float
			       :symbol :categorical))





