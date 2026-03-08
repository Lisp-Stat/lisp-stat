;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf tooth-growth (read-csv rdata:toothgrowth)
  "The Effect of Vitamin C on Tooth Growth in Guinea Pigs

Description
The response is the length of odontoblasts (cells responsible for
tooth growth) in 60 guinea pigs. Each animal received one of three
dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery
methods, orange juice or ascorbic acid (a form of vitamin C and coded
as VC).

Format
A data frame with 60 observations on 3 variables.
[,0] 	len 	numeric 	Tooth length
[,1] 	supp 	factor 	        Supplement type (VC or OJ).
[,2] 	dose 	numeric 	Dose in milligrams/day

Source
C. I. Bliss (1952). The Statistics of Bioassay. Academic Press.

References
- McNeil, D. R. (1977). Interactive Data Analysis. New York: Wiley.
- Crampton, E. W. (1947). The growth of the odontoblast of the incisor
  teeth as a criterion of vitamin C intake of the guinea pig. The
  Journal of Nutrition, 33(5), 491–504. doi: 10.1093/jn/33.5.491.

Examples

(vega:defplot tooth-growth-coplot
  `(:title \"Tooth Growth: Length vs Dose | Supplement\"
    :data (:url \"/table/TOOTH-GROWTH\")
    :facet (:field :supp
            :type  :nominal
            :title \"Supplement (Given)\"
            :header (:title-font-size 13
                     :label-font-size 12
                     :label-font-weight \"bold\"))
    :spec
    (:width 280
     :height 260
     :encoding (:x (:field :dose
                    :type  :quantitative
                    :scale (:zero :false)
                    :axis  (:values #(0.5 1.0 2.0)
                            :title \"Dose (mg/day)\")))
     :layer
     #((:mark (:type :point :filled t :opacity 0.6)
        :encoding (:y     (:field :len :type :quantitative :title \"Tooth Length\")
                   :color (:field :supp :type :nominal :legend :null)))
       (:mark (:type :line :stroke-width 2.5 :point t)
        :encoding (:y     (:field :len :type :quantitative :aggregate :mean)
                   :color (:field :supp :type :nominal :legend :null)))
       (:mark (:type :errorbar :extent :stdev)
        :encoding (:y     (:field :len :type :quantitative)
                   :color (:field :supp :type :nominal :legend :null)))))))
")

(remove-column! tooth-growth (first-elt (keys tooth-growth))) ;row number
(set-properties tooth-growth :label '(:len   "Tooth length"
				      :supp  "Supplement type (VC or OJ)"
				      :dose  "Dose"))
(set-properties tooth-growth :unit '(:dose  mg/day))
(heuristicate-types tooth-growth)
(set-properties tooth-growth :type '(:supp :categorical))  ; Categorical variables cannot be automatically determined

tooth-growth
