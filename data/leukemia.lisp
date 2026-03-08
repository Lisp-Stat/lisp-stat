(require "bayes")

(defparameter wbc-pos #(2300 750 4300 2600 6000 10500 10000 17000 5400 7000
                   9400 32000 35000 100000 100000 52000 100000))

(defparameter transformed-wbc-pos (e- (elog wbc-pos) (elog 10000)))

(defparameter times-pos #(65 156 100 134 16 108 121 4 39 143 56 26 22 1 1 5 65))

;FIXME
(defun llik-pos (theta)
  (let* ((x transformed-wbc-pos)
	 (y times-pos)
	 (theta0 (select theta 0))
	 (theta1 (select theta 1))
	 (t1x (* theta1 x)))
    (- (sum t1x)
       (* (length x) (log theta0))
       (/ (sum (* y (exp t1x)))
	  theta0))))
;FIXME
(defun lk-sprob (theta)
  (let* ((time 52.0)
         (x (log 5))
         (mu (* (select theta 0) (exp (- (* (select theta 1) x))))))
    (exp (- (/ time mu)))))
