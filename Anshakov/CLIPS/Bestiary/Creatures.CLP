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
            (Class Creature)))
)

(defrule ToVisible
    (Classification (ID ?x) (Class Creature))
    (Description (ID ?x) (Features $?s is_visible Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Visible)))
)

(defrule ToInvisible
   (Classification (ID ?x) (Class Creature))
   (Description (ID ?x)(Features $?s is_visible No $?f))
    =>
   (assert (Classification (ID ?x)	
           (Class Invisible)))
)

(defrule ToStarVampire
    (Classification (ID ?x) (Class Invisible))
    (Description (ID ?x)(Features $?s sound Chuckle $?f))
    =>
   (assert (Classification (ID ?x)
           (Class StarVampire) (Flag 1)))
)

(defrule ToFlyingPolyp
    (Classification (ID ?x) (Class Invisible))
    (Description (ID ?x)(Features $?s sound high_pitched_whistling $?f))
    =>
    (assert (Classification (ID ?x)
            (Class FlyingPolyp) (Flag 1)))
)

(defrule ToVisibleWithoutPermanentForm
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s permanent_form No $?f))
    =>
    (assert (Classification (ID ?x)
            (Class VisibleWithoutPremanentForm) (Flag 1)))
)

(defrule ToVisibleWithManyForms
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s permanent_form Many $?f))
    =>
    (assert (Classification (ID ?x)
            (Class VisibleWithManyForms) (Flag 1)))
)

(defrule ToVisibleWithPermanentForm
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s permanent_form Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class VisibleWithPremanentForm)))
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