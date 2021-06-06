;;; Compound Interest Calculator
;;; Author: Cooper Baird

(defun compound-interest (base yearly-contribution interest years)
    "Function to calculate the compound interest."
    (setq result (+ yearly-contribution (* base (+ 1 (/ interest 100)))))
    (if (= years 1)
        (return-from compound-interest result))
    (compound-interest result yearly-contribution interest (- years 1)))

;; Retrieved here:
;; https://stackoverflow.com/questions/39335134/how-to-format-money-with-cl-format-clojure-implementation-of-common-lisp-format
;; I was annoyed to find out this wasn't a simple format string
(defun money (stream number colonp atsignp &optional (decimal-places 2))
  (multiple-value-bind (integral decimal) (truncate number)
    (format stream
            (concatenate 'string
                         "~"
                         (and colonp ":")
                         (and atsignp "@")
                         "D"
                         "~0,vf")
            integral
            decimal-places
            (abs decimal))))

(setf *read-default-float-format* 'double-float)
;; End of retrieved code

(princ "What is your base amount? ")
(setq base (read))

(princ "What is your yearly contribution? ")
(setq contribution (read))

(princ "What is the yearly interest as a percent? ")
(setq interest (read))

(princ  "For how many years do you want the calculation? ")
(setq years (read))

(terpri)
(format t "$~2:/money/" (compound-interest base contribution interest years))
