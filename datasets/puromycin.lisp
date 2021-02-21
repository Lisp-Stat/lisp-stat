(require "nonlin")

(def x1 (list 0.02 0.02 0.06 0.06 .11 .11 .22 .22 .56 .56 1.1 1.1))

(def x2 (list 0.02 0.02 0.06 0.06 .11 .11 .22 .22 .56 .56 1.1))

(def y1 (list 76 47 97 107 123 139 159 152 191 201 207 200))

(def y2 (list 67 51 84 86 98 115 131 124 144 158 160))

(defun f1 (theta)
  "The Michaelis-Menten function for the velocity of an enzymatic reaction
as a function of the substrate concentration.  THETA is a parameter
vector of length 2 consisting of the asymptotic velocity and the
concentration at which half the asymptotic velocity is attained."
  (/ (* (select theta 0) x1) (+ (select theta 1) x1)))

(defun f2 (theta)
  "The Michaelis-Menten function for the velocity of an enzymatic reaction
as a function of the substrate concentration.  THETA is a parameter
vector of length 2 consisting of the asymptotic velocity and the
concentration at which half the asymptotic velocity is attained."
  (/ (* (select theta 0) x2) (+ (select theta 1) x2)))

