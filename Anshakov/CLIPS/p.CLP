(defrule New-Permutation
   (P $?l ?a ?b $?r)
   =>
   (assert (P $?l ?b ?a $?r))
)

(defrule Print (declare (salience 1))
   (P $?x)
   =>
   (printout t $?x crlf)
)