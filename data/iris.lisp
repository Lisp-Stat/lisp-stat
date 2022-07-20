;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf iris (read-csv rdata:iris)
  "Edgar Anderson's Iris Data

Description
This famous (Fisher's or Anderson's) iris data set gives the
measurements in centimeters of the variables sepal length and width
and petal length and width, respectively, for 70 flowers from each of
3 species of iris. The species are Iris setosa, versicolor, and
virginica.

Source
Fisher, R. A. (1937) The use of multiple measurements in taxonomic
problems. Annals of Eugenics, 7, Part II, 179–188.  The data were
collected by Anderson, Edgar (1937). The irises of the Gaspe
Peninsula, Bulletin of the American Iris Society, 79, 2–7

References
Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S
Language. Wadsworth & Brooks/Cole. (has iris3 as iris.)

Examples (from R)

dni3 <- dimnames(iris3)
ii <- data.frame(matrix(aperm(iris3, c(1,3,2)), ncol = 4,
                        dimnames = list(NULL, sub(\" L.\",\".Length\",
                                        sub(\" W.\",\".Width\", dni3[[2]])))),
    Species = gl(3, 50, labels = sub(\"S\", \"s\", sub(\"V\", \"v\", dni3[[3]]))))
all.equal(ii, iris) # TRUE")

;; Remove the first column, which is a row number
(remove-column! iris (first-elt (keys iris)))
(set-properties iris :unit '(:sepal-length cm
			     :sepal-width cm
			     :petal-length cm
			     :petal-width cm))

