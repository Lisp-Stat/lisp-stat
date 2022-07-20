;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-
(in-package #:ls-user)

(defdf plant-growth (read-csv rdata:plantgrowth)
  "Results from an Experiment on Plant Growth

Description
Results from an experiment to compare yields (as measured by dried
weight of plants) obtained under a control and two different treatment
conditions.

Format
A data frame of 30 cases on 2 variables.
[, 1] 	weight 	numeric
[, 2] 	group 	factor

The levels of group are ‘ctrl’, ‘trt1’, and ‘trt2’.

Source
Dobson, A. J. (1983) An Introduction to Statistical Modelling. London:
Chapman and Hall.

Examples (from R)

## One factor ANOVA example from Dobson's book, cf. Table 7.4:
require(stats); require(graphics)
boxplot(weight ~ group, data = PlantGrowth, main = \"PlantGrowth data\",
        ylab = \"Dried weight of plants\", col = \"lightgray\",
        notch = TRUE, varwidth = TRUE)
anova(lm(weight ~ group, data = PlantGrowth))")

(remove-column! plant-growth (first-elt (keys plant-growth)))
(set-properties plant-growth :label '(:weight "Weight"
				      :group  "Group"))
(heuristicate-types plant-growth)
(set-properties plant-growth :type '(:group :categorical))  ; Categorical variables cannot be automatically determined

plant-growth
