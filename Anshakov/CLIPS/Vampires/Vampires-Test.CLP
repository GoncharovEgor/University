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

(defrule D-Corpse (declare (salience 10))
    (Classification (ID ?x) (Class Vampire))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Corpse $?r)))
    =>
    (printout t ?x ": Corpse (Yes/No)? > ")
    (bind ?Corpse (read))
    (if (eq ?Corpse Yes) then (modify ?d (Features $?y Corpse Yes)))
    (if (eq ?Corpse No) then (modify ?d (Features $?y Corpse No)))
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

(defrule D-Bloodsucker (declare (salience 8))
    (Classification (ID ?x) (Class Spirit))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Bloodsucker $?r)))
    =>
    (printout t ?x ": Bloodsucker (Yes/No)? > ")
    (bind ?Bloodsucker (read))
    (if (subsetp (create$ ?Bloodsucker) (create$ Yes No)) then (modify ?d (Features $?y Bloodsucker ?Bloodsucker)))
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

(defrule D-Bodytaker (declare (salience 6))
    (Classification (ID ?x) (Class Leech))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Bodytaker $?r)))
    =>
    (printout t ?x ": Bodytaker (Yes/No)? > ")
    (bind ?Bodytaker (read))
    (if (subsetp (create$ ?Bodytaker) (create$ Yes No)) then (modify ?d (Features $?y Bodytaker ?Bodytaker)))
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

(defrule D-AnimalBody (declare (salience 4))
    (Classification (ID ?x) (Class Pest))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l AnimalBody $?r)))
    =>
    (printout t ?x ": AnimalBody (Yes/No)? > ")
    (bind ?AnimalBody (read))
    (if (subsetp (create$ ?AnimalBody) (create$ Yes No)) then (modify ?d (Features $?y AnimalBody ?AnimalBody)))
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


(defrule D-Birdlike (declare (salience 4))
    (Classification (ID ?x) (Class Ghost))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Birdlike $?r)))
    =>
    (printout t ?x ": Birdlike (Yes/No)? > ")
    (bind ?Birdlike (read))
    (if (subsetp (create$ ?Birdlike) (create$ Yes No)) then (modify ?d (Features $?y Birdlike ?Birdlike)))
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

(defrule D-Lightning-summoner (declare (salience 2))
    (Classification (ID ?x) (Class Bird))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Lightning-summoner $?r)))
    =>
    (printout t ?x ": Lightning-summoner (Yes/No)? > ")
    (bind ?Lightning-summoner (read))
    (if (subsetp (create$ ?Lightning-summoner) (create$ Yes No)) then (modify ?d (Features $?y Lightning-summoner ?Lightning-summoner)))
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


(defrule Print (declare (salience -1))
    (Classification (ID ?x) (Class ?y) (Flag 1))
    =>
    (printout t ?x " is a(n) " ?y crlf)
)
