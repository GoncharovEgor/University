(deftemplate Person
(slot Name (type SYMBOL) (default John))
(slot Sex (type SYMBOL) (default Male))
(slot Age(type INTEGER) (default 20))
)

(defrule pairs
(Person (Name ?x) (Sex Male) (Age ?y))
(Person (Name ?z) (Sex Female) (Age ?w))
(test (>= ?y ?w))
=>
(assert (P ?x ?y ?z ?w))
)
 
(defrule Print
(P $?p)
=>
(printout t $?p crlf)
)

(deffacts  Persons
(Person (Name John) (Sex Male) (Age 20))
(Person (Name Jane) (Sex Female) (Age 18))
(Person (Name Stephen) (Sex Male) (Age 35))
(Person (Name Mary) (Sex Female) (Age 33))
)
