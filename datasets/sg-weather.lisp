;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: LS-USER -*-

(defdf sg-weather
  (alist-df
   '((max-temps . #(30.1 30.3 30.3 30.8 31.6 31.5 32.7 32.1 32.1 31.4 31.9 31.7 32.2 31.1))
     (min-temps . #(24.6 25.4 25.1 24.5 23.7 25.6 24.6 24.7 25.0 25.2 25.1 25.6 25.5 25.2))
     (precipitation . #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.6 0.4 0.0 0.0 ))))
  "Two week sample of Singapore weather data from April 2021")
