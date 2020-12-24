(defrule Permutation 
(P $?l ?x ?y $?r)
=>
(assert (P $?l ?y ?x $?r))
)

(defrule Print (declare (salience 1))
(P $?p)
=>
(printout t $?p crlf)
)



(deffacts P
(P a b c d)
)