(defrule Cart
(A $?l ?x $?r)
(B $?L ?y $?R)
=>
(assert (P ?x ?y))
)

(defrule Print (declare (salience 1))
(P $?p)
=>
(printout t $?p crlf)
)



(deffacts Sets
(A 1 2 3 4 5 6)
(B a b c d)
)