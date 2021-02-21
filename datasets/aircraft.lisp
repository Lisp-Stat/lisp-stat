(require "maximize")

(def failure-times
     '((413 14 58 37 100 65 9 169 447 184 36 201 118 34 31 
            18 18 67 57 62 7 22 34)
       (90 10 60 186 61 49 14 24 56 20 79 84 44 59 29 118 25 156 
           310 76 26 44 23 62 130 208 70 101 208)
       (74 57 48 29 502 12 70 21 29 386 59 27 153 26 326)
       (55 320 65 104 220 239 47 246 176 182 33 15 104 35)
       (23 261 87 7 120 14 62 47 225 71 246 21 42 20 5 12 120 
           11 3 14 71 11 14 11 16 90 1 16 52 95)))

(def x (select failure-times 1))

(defun gllik (theta)
  (let* ((mu (select theta 0))
         (beta (select theta 1))
         (n (length x))
         (bym (* x (/ beta mu))))
    (+ (* n (- (log beta) (log mu) (log-gamma beta)))
       (sum (* (- beta 1) (log bym)))
       (sum (- bym)))))
