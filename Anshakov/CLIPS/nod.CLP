(deffunction HOD (?n ?m)
(while (<> ?n ?m)
	(if (> ?n ?m) then (bind ?n (- ?n ?m))
	else (bind ?m (- ?m ?n))))
(return ?n)
)

(defrule Work
=>
(printout t "n =  ")
(bind ?n (read))
(printout t "m =  ")
(bind ?m (read))
(printout t ?n " HOD " ?m " = " (HOD ?n ?m) crlf)
)
