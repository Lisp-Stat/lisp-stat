;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package #:rdata
    (:use :cl)
  (:export #:index
	   #:base-url
	   #:load-r-default-datasets
	   #:save-r-default-datasets
	   #:get-r-data
	   #:load-r-metadata
	   #:*r-default-datasets*

	   ;; Individual data sets
	   #:airpassengers #:ability.cov #:airmiles #:airquality
	   #:anscombe #:attenu #:attitude  #:austres
	   #:BJsales #:BOD
	   #:cars #:ChickWeight #:chickwts #:CO2-1 #:co2-2 #:crimtab
	   #:discoveries #:DNase
	   #:esoph #:euro #:EuStockMarkets
	   #:faithful #:Formaldehyde #:freeny
	   #:HairEyeColor #:Harman23.cor #:Harman74.cor
	   #:Indometh #:infert #:InsectSprays #:iris #:iris3 #:islands
	   #:JohnsonJohnson
	   #:LakeHuron #:lh #:LifeCycleSavings #:Loblolly #:longley #:lynx
	   #:morley #:mtcars
	   #:nhtemp #:Nile #:nottem #:npk
	   #:nycflights13-airlines #:nycflights13-airports #:nycflights13-flights #:nycflights13-planes #:nycflights13-weather
	   #:occupationalStatus #:Orange #:OrchardSprays
	   #:PlantGrowth #:precip #:presidents #:pressure #:Puromycin
	   #:quakes
	   #:randu #:rivers #:rock
	   #:Seatbelts #:sleep #:stackloss #:sunspot.month #:sunspot.year #:sunspots #:swiss
	   #:Theoph #:Titanic #:ToothGrowth #:treering #:trees
	   #:UCBAdmissions #:UKDriverDeaths #:UKgas #:USAccDeaths #:USArrests
	   #:USJudgeRatings #:USPersonalExpenditure #:uspop
	   #:VADeaths #:volcano
	   #:warpbreaks #:women #:WorldPhones #:WWWusage))

(in-package :rdata)

(defparameter index "http://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/datasets.csv")
(defparameter base-url "http://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv"
  "Base URL for datasets included in R")
(defparameter *r-default-dataframes* nil
  "Data frames corresponding to the default R datasets")

(defvar *r-default-datasets* '(airpassengers ability.cov airmiles airquality anscombe attenu attitude austres BJsales BOD cars ChickWeight chickwts CO2-1 co2-2 crimtab discoveries DNase esoph euro EuStockMarkets faithful Formaldehyde freeny HairEyeColor Harman23.cor Harman74.cor Indometh infert InsectSprays iris iris3 islands JohnsonJohnson LakeHuron lh LifeCycleSavings Loblolly longley lynx morley mtcars nhtemp Nile nottem npk occupationalStatus Orange OrchardSprays PlantGrowth precip presidents pressure Puromycin quakes randu rivers rock Seatbelts student-sleep stackloss sunspot.month sunspot.year sunspots swiss Theoph Titanic ToothGrowth treering trees UCBAdmissions UKDriverDeaths UKgas USAccDeaths USArrests USJudgeRatings USPersonalExpenditure uspop VADeaths volcano warpbreaks women WorldPhones WWWusage)
  "All data sets included by default in R")


;;; Data for tutorials, documentation, examples not in the default datasets

(defvar nycflights13-airlines "http://vincentarelbundock.github.io/Rdatasets/csv/nycflights13/airlines.csv"
  "Airline name lookup table by carrier code")
(defvar nycflights13-airports "http://vincentarelbundock.github.io/Rdatasets/csv/nycflights13/airports.csv"
  "Airport metadata")
(defvar nycflights13-flights "http://vincentarelbundock.github.io/Rdatasets/csv/nycflights13/flights.csv"
  "On-time data for all flights that departed NYC (i.e. JFK, LGA or EWR) in 2013")
(defvar nycflights13-planes "http://vincentarelbundock.github.io/Rdatasets/csv/nycflights13/planes.csv"
  "Metadata for all airplane tail numbers found in the FAA aircraft registry")
(defvar nycflights13-weather "http://vincentarelbundock.github.io/Rdatasets/csv/nycflights13/weather.csv"
  "Hourly meterological data for LGA, JFK and EWR in 2013")




;;; Data

(defvar airpassengers "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/AirPassengers.csv"
  "Monthly Airline Passenger Numbers 1949-1960")
(defvar ability.cov "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/ability.cov.csv"
  "Ability and Intelligence Tests")
(defvar airmiles "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/airmiles.csv"
  "Passenger Miles on Commercial US Airlines, 1937-1960")
(defvar airquality "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/airquality.csv"
  "New York Air Quality Measurements")
(defvar anscombe "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/anscombe.csv"
  "Anscombe's Quartet of 'Identical' Simple Linear Regressions")
(defvar attenu "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/attenu.csv"
  "The Joyner-Boore Attenuation Data")
(defvar attitude "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/attitude.csv"
  "The Chatterjee-Price Attitude Data")
(defvar austres "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/austres.csv"
  "Quarterly Time Series of the Number of Australian Residents")

(defvar BJsales "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/BJsales.csv"
  "Sales Data with Leading Indicator")
(defvar BOD "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/BOD.csv"
  "Biochemical Oxygen Demand")

(defvar cars "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/cars.csv"
  "Speed and Stopping Distances of Cars")
(defvar ChickWeight "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/ChickWeight.csv"
  "Weight versus age of chicks on different diets")
(defvar chickwts "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/chickwts.csv"
  "Chicken Weights by Feed Type")
(defvar CO2-1 "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/CO2.csv"
  "Carbon Dioxide Uptake in Grass Plants")
(defvar co2-2 "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/co2.csv"
  "Mauna Loa Atmospheric CO2 Concentration")
(defvar crimtab "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/crimtab.csv"
  "Student's 3000 Criminals Data")

(defvar discoveries "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/discoveries.csv"
  "Yearly Numbers of Important Discoveries")
(defvar DNase "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/DNase.csv"
  "Elisa assay of DNase")

(defvar esoph "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/esoph.csv"
  "Smoking, Alcohol and (O)esophageal Cancer")
(defvar euro "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/euro.csv"
  "Conversion Rates of Euro Currencies")
(defvar EuStockMarkets "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/EuStockMarkets.csv"
  "Daily Closing Prices of Major European Stock Indices, 1991-1998")


(defvar faithful "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/faithful.csv"
  "Old Faithful Geyser Data")
(defvar Formaldehyde "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Formaldehyde.csv"
  "Determination of Formaldehyde")
(defvar freeny "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/freeny.csv"
  "Freeny's Revenue Data")

(defvar HairEyeColor "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/HairEyeColor.csv"
  "Hair and Eye Color of Statistics Students")
(defvar Harman23.cor "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Harman23.cor.csv"
  "Harman Example 2.3")
(defvar Harman74.cor "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Harman74.cor.csv"
  "Harman Example 7.4")

(defvar Indometh "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Indometh.csv"
  "Pharmacokinetics of Indomethacin")
(defvar infert "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/infert.csv"
  "Infertility after Spontaneous and Induced Abortion")
(defvar InsectSprays "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/InsectSprays.csv"
  "Effectiveness of Insect Sprays")
(defvar iris "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/iris.csv"
  "Edgar Anderson's Iris Data")
(defvar iris3 "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/iris3.csv"
  "Edgar Anderson's Iris Data")
(defvar islands "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/islands.csv"
  "Areas of the World's Major Landmasses")

(defvar JohnsonJohnson "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/JohnsonJohnson.csv"
  "Quarterly Earnings per Johnson & Johnson Share")

(defvar LakeHuron "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/LakeHuron.csv"
  "Level of Lake Huron 1875-1972")
(defvar lh "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/lh.csv"
  "Luteinizing Hormone in Blood Samples")
(defvar LifeCycleSavings "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/LifeCycleSavings.csv"
  "Intercountry Life-Cycle Savings Data")
(defvar Loblolly "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Loblolly.csv"
  "Growth of Loblolly pine trees")
(defvar longley "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/longley.csv"
  "Longley's Economic Regression Data")
(defvar lynx "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/lynx.csv"
  "Annual Canadian Lynx trappings 1821-1934")

(defvar morley "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/morley.csv"
  "Michelson Speed of Light Data")
(defvar mtcars "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/mtcars.csv"
  "Motor Trend Car Road Tests")
(defvar nhtemp "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/nhtemp.csv"
  "Average Yearly Temperatures in New Haven")
(defvar Nile "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Nile.csv"
  "Flow of the River Nile")
(defvar nottem "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/nottem.csv"
  "Average Monthly Temperatures at Nottingham, 1920-1939")
(defvar npk "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/npk.csv"
  "Classical N, P, K Factorial Experiment")

(defvar occupationalStatus "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/occupationalStatus.csv"
  "Occupational Status of Fathers and their Sons")
(defvar Orange "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Orange.csv"
  "Growth of Orange Trees")
(defvar OrchardSprays "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/OrchardSprays.csv"
  "Potency of Orchard Sprays")

(defvar PlantGrowth "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/PlantGrowth.csv"
  "Results from an Experiment on Plant Growth")
(defvar precip "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/precip.csv"
  "Annual Precipitation in US Cities")
(defvar presidents "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/presidents.csv"
  "Quarterly Approval Ratings of US Presidents")
(defvar pressure "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/pressure.csv"
  "Vapor Pressure of Mercury as a Function of Temperature")
(defvar Puromycin "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Puromycin.csv"
  "Reaction Velocity of an Enzymatic Reaction")

(defvar quakes "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/quakes.csv"
  "Locations of Earthquakes off Fiji")

(defvar randu "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/randu.csv"
  "Random Numbers from Congruential Generator RANDU")
(defvar rivers "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/rivers.csv"
  "Lengths of Major North American Rivers")
(defvar rock "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/rock.csv"
  "Measurements on Petroleum Rock Samples")

(defvar Seatbelts "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Seatbelts.csv"
  "Road Casualties in Great Britain 1969-84")
(defvar student-sleep "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/sleep.csv"
  "Student's Sleep Data")
(defvar stackloss "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/stackloss.csv"
  "Brownlee's Stack Loss Plant Data")
(defvar sunspot.month "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/sunspot.month.csv"
  "Monthly Sunspot Data, from 1749 to Present")
(defvar sunspot.year "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/sunspot.year.csv"
  "Yearly Sunspot Data, 1700-1988")
(defvar sunspots "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/sunspots.csv"
  "Monthly Sunspot Numbers, 1749-1983")
(defvar swiss "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/swiss.csv"
  "Swiss Fertility and Socioeconomic Indicators (1888) Data")

(defvar Theoph "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Theoph.csv"
  "Pharmacokinetics of Theophylline")
(defvar Titanic "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/Titanic.csv"
  "Survival of passengers on the Titanic")
(defvar ToothGrowth "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/ToothGrowth.csv"
  "The Effect of Vitamin C on Tooth Growth in Guinea Pigs")
(defvar treering "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/treering.csv"
  "Yearly Treering Data, -6000-1979")
(defvar trees "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/trees.csv"
  "Diameter, Height and Volume for Black Cherry Trees")

(defvar UCBAdmissions "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/UCBAdmissions.csv"
  "Student Admissions at UC Berkeley")
(defvar UKDriverDeaths "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/UKDriverDeaths.csv"
  "Road Casualties in Great Britain 1969-84")
(defvar UKgas "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/UKgas.csv"
  "UK Quarterly Gas Consumption")
(defvar USAccDeaths "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/USAccDeaths.csv"
  "Accidental Deaths in the US 1973-1978")
(defvar USArrests "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/USArrests.csv"
  "Violent Crime Rates by US State")
(defvar USJudgeRatings "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/USJudgeRatings.csv"
  "Lawyers' Ratings of State Judges in the US Superior Court")
(defvar USPersonalExpenditure "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/USPersonalExpenditure.csv"
  "Personal Expenditure Data")
(defvar uspop "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/uspop.csv"
  "Populations Recorded by the US Census")

(defvar VADeaths "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/VADeaths.csv"
  "Death Rates in Virginia (1940)")
(defvar volcano "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/volcano.csv"
  "Topographic Information on Auckland's Maunga Whau Volcano")

(defvar warpbreaks "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/warpbreaks.csv"
  "The Number of Breaks in Yarn during Weaving")
(defvar women "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/women.csv"
  "Average Heights and Weights for American Women")
(defvar WorldPhones "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/WorldPhones.csv"
  "The World's Telephones")
(defvar WWWusage "http://vincentarelbundock.github.io/Rdatasets/csv/datasets/WWWusage.csv"
    "Internet Usage per Minute")


(defun load-r-default-datasets ()
  "Load the data sets included in base R"
  (map nil #'(lambda (x)
	       (format t "Processing ~A" (make-symbol (symbol-name x)))
	       (pushnew (eval `(df:defdf ,(intern (symbol-name x))
				   (dfio:read-csv (dex:get ,(symbol-value x) :want-stream t))
				 ,(documentation x 'variable)))
			*r-default-dataframes*))
       rdata:*r-default-datasets*))

(defun save-r-default-datasets ()
  "Save the data sets included in base R"
  (map nil #'(lambda (x)
	       (eval `(dfio:save ,x
			    (make-pathname :host "LS"
					   :directory '(:absolute "DATASETS" "R")
					   :name (dfio:symbol-name-to-pathname ,(symbol-name x))
					   :type "lisp"))))
       *r-default-dataframes*))

(defun get-r-data ()
  (load-r-default-datasets)
  (save-r-default-datasets))

(defun load-r-metadata ()
  "Loads the master R data set index as a data frame

This allows you to slice & dice the 1500+ data sets to find what you need"
  (eval '(df:defdf all-r-datasets
	  (dfio:read-csv (dex:get index :want-stream t))
	  "Master index for all vincentarelbundock R data sets")))
