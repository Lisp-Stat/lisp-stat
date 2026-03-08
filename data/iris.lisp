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

Examples

# Reconstructing IRIS from IRIS3

## Overview
Demonstrates converting a 3-dimensional array (iris3) back into a flat
data frame equivalent to R's built-in `iris` dataset.  Mirrors the R
idiom:
```r
dni3 <- dimnames(iris3)
ii <- data.frame(
  matrix(aperm(iris3, c(1,3,2)), ncol=4, ...),
  Species = gl(3, 50, labels=...))
all.equal(ii, iris) # TRUE
```

## Array Layout
```
iris3  : [50 x 4 x 3]  — observations x measurements x species
iris   : [150 x 5]     — (observations*species) x (measurements+species)
```

## Step 1: Load flat iris and build iris3
```lisp
(defparameter iris-df (read-csv rdata:iris))

;; Pull the 4 numeric columns as a [150 x 4] matrix
(defparameter iris-matrix
  (aops:as-array (select iris-df t '(sepal-length sepal-width
                                     petal-length petal-width))))

;; Reshape [150,4] → [3,50,4] then permute → [50,4,3]
;; so that iris3[obs, measurement, species] matches R's layout
(defparameter iris3
  (aops:permute '(1 2 0)
    (aops:reshape iris-matrix '(3 50 4))))
```

## Step 2: Reconstruct iris from iris3
#|

```lisp
(let* ((col-keys
         (map 'list
              (lambda (s)
                (intern (string-upcase
                          (cl-ppcre:regex-replace \" W\\.\"
                            (cl-ppcre:regex-replace \" L\\.\" s \".Length\")
                            \".Width\"))
                        :keyword))
              #(\"Sepal L.\" \"Sepal W.\" \"Petal L.\" \"Petal W.\")))
       (mat     (aops:reshape (aops:permute '(2 0 1) iris3) '(150 4)))
       (cols    (map 'list
                     (lambda (c) (coerce c 'simple-vector))
                     (aops:split (aops:permute '(1 0) mat) 1)))
       (species (aops:generate
                  (lambda (i)
                    (svref #(\"setosa\" \"versicolor\" \"virginica\") (floor i 50)))
                  150 :position))
       (plist   (append
                  (loop :for k :in col-keys
                        :for c :in cols
                        :nconc (list k c))
                  (list :species species))))
  (plist-df plist))
```
|#
## Key Decisions

### aops:as-array vs df:as-array
Use `aops:as-array` (not `df:as-array`) to convert the selected columns
to a numeric array suitable for `aops:reshape`.

### Index Translation: aperm(iris3, c(1,3,2))
R uses 1-based indexing; `c(1,3,2)` becomes `(2 0 1)` in 0-based
Lisp-Stat.  Transforms `[50,4,3]` → `[3,50,4]`, so reshaping to
`[150,4]` groups species contiguously: setosa rows 0-49, versicolor
50-99, virginica 100-149.

### Extracting Column Vectors
`mat` is `[150,4]`.  Transposing to `[4,150]` then splitting along
axis 1 yields 4 length-150 vectors — one per measurement:
```lisp
(aops:split (aops:permute '(1 0) mat) 1)
```

Each displaced sub-array is then coerced to `simple-vector` before
being passed to `plist-df`.

### Column Name Translation
R's nested `sub()` calls become nested `cl-ppcre:regex-replace` calls,
and the result is interned as a keyword:

| Input    | Output         |
|----------|----------------|
| Sepal L. | :SEPAL-LENGTH  |
| Sepal W. | :SEPAL-WIDTH   |
| Petal L. | :PETAL-LENGTH  |
| Petal W. | :PETAL-WIDTH   |

### Species Factor: gl(3, 50, labels=...)
R's `gl(3, 50)` is reproduced with `aops:generate` over position index:
```lisp
(aops:generate
  (lambda (i)
    (svref #(\"setosa\" \"versicolor\" \"virginica\") (floor i 50)))
  150 :position)
```

### Building the plist for plist-df
A `loop` interleaves keys and column vectors, with `:species` appended:
```lisp
(append
  (loop :for k :in col-keys
        :for c :in cols
        :nconc (list k c))
  (list :species species))
```

## Result
```lisp
(plist-df plist) ; => 150 observations x 5 variables
                 ;    :SEPAL-LENGTH :SEPAL-WIDTH
                 ;    :PETAL-LENGTH :PETAL-WIDTH :SPECIES
```

## Notes

- `RDATA:IRIS` is pre-sorted by species (50 setosa, 50 versicolor,
  50 virginica), so no additional sorting is needed when building `iris3`.
- Column names are interned as symbols (not keywords) by `READ-CSV`;
  use unqualified symbols e.g. `sepal-length` not `:sepal-length`
  when selecting columns with `SELECT`.
- `AOPS:SPLIT` returns displaced arrays; always `coerce` to
  `simple-vector` before passing to `plist-df`.
"

;; Remove the first column, which is a row number
(remove-column! iris (first-elt (keys iris)))
(set-properties iris :unit '(:sepal-length cm
			     :sepal-width cm
			     :petal-length cm
			     :petal-width cm))

