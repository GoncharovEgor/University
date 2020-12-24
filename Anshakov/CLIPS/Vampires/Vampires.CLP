(deftemplate Description
    (slot ID (type SYMBOL) (default ?NONE))
    (multislot Features)
)
(deftemplate Classification
    (slot ID (type SYMBOL) (default ?NONE))
    (slot Class (type SYMBOL) (default ?NONE))
    (slot Flag (type INTEGER) (default 0))
)

(defrule ToRoot
    (Description (ID ?x))
    =>
    (assert (Classification (ID ?x)
            (Class Vampire)))
)

(defrule ToUpyr
    (Classification (ID ?x) (Class Vampire))
    (Description (ID ?x) (Features $?s Corpse Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Upyr) (Flag 1)))
)

(defrule ToSpirit
   (Classification (ID ?x) (Class Vampire))
   (Description (ID ?x)(Features $?s Corpse No $?f))
    =>
   (assert (Classification (ID ?x)	
           (Class Spirit)))
)

(defrule ToJiangshi
    (Classification (ID ?x) (Class Spirit))
    (Description (ID ?x)(Features $?s Bloodsucker No $?f))
    =>
   (assert (Classification (ID ?x)
           (Class Jiangshi) (Flag 1)))
)

(defrule ToLeech
    (Classification (ID ?x) (Class Spirit))
    (Description (ID ?x)(Features $?s Bloodsucker Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Leech)))
)

(defrule ToGhost
    (Classification (ID ?x) (Class Leech))
    (Description (ID ?x)(Features $?s Bodytaker No $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Ghost)))
)

(defrule ToPest
    (Classification (ID ?x) (Class Leech))
    (Description (ID ?x)(Features $?s Bodytaker Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Pest)))
)

(defrule ToUbur
    (Classification (ID ?x) (Class Pest))
    (Description (ID ?x)(Features $?s AnimalBody No $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Ubur) (Flag 1)))
)


(defrule ToVetala
    (Classification (ID ?x) (Class Pest))
    (Description (ID ?x)(Features $?s AnimalBody Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Vetala) (Flag 1)))
)

(defrule ToManananggal
   (Classification (ID ?x) (Class Ghost))
   (Description (ID ?x)(Features $?s Birdlike No $?f))
   =>
   (assert (Classification (ID ?x)
           (Class Manananggal) (Flag 1)))
)


(defrule ToBird
   (Classification (ID ?x) (Class Ghost))
   (Description (ID ?x)(Features $?s Birdlike Yes $?f))
   =>
   (assert (Classification (ID ?x)
           (Class Bird)))
)

(defrule ToImpundulu
    (Classification (ID ?x) (Class Bird))
    (Description (ID ?x)(Features $?s Lightning-summoner Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Impundulu) (Flag 1)))
)

(defrule ToStrix
    (Classification (ID ?x) (Class Bird))
    (Description (ID ?x)(Features $?s Lightning-summoner No $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Strix) (Flag 1)))
)

(defrule Print
    (Classification (ID ?x) (Class ?y) (Flag 1))
    =>
    (printout t ?x " is a(n) " ?y crlf)
)
