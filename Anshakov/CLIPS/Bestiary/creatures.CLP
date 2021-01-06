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
    (Description (ID ?x) (Features $?s IsVisible Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Visible)))
)

(defrule ToInvisible
   (Classification (ID ?x) (Class Creature))
   (Description (ID ?x)(Features $?s IsVisible No $?f))
    =>
   (assert (Classification (ID ?x)	
           (Class Invisible)))
)

(defrule ToStarVampire
    (Classification (ID ?x) (Class Invisible))
    (Description (ID ?x)(Features $?s Sound Chuckle $?f))
    =>
   (assert (Classification (ID ?x)
           (Class StarVampire) (Flag 1)))
)

(defrule ToFlyingPolyp
    (Classification (ID ?x) (Class Invisible))
    (Description (ID ?x)(Features $?s Sound HighPitchedWhistling $?f))
    =>
    (assert (Classification (ID ?x)
            (Class FlyingPolyp) (Flag 1)))
)

(defrule ToVisibleWithPermanentForm
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s PermanentForm Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class VisibleWithPremanentForm)))
)

(defrule ToVisibleWithoutPermanentForm
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s PermanentForm No $?f))
    =>
    (assert (Classification (ID ?x)
            (Class VisibleWithoutPremanentForm) (Flag 1)))
)

(defrule ToNyarlathotep
    (Classification (ID ?x) (Class Visible))
    (Description (ID ?x)(Features $?s PermanentForm Many $?f))
    =>
    (assert (Classification (ID ?x)
            (Class Nyarlathotep) (Flag 1)))
)


(defrule ToWormLikeVisibleWithPermanentForm
    (Classification (ID ?x) (Class VisibleWithPremanentForm))
    (Description (ID ?x)(Features $?s WormLike Yes $?f))
    =>
    (assert (Classification (ID ?x)
            (Class WormLikeVisibleWithPermanentForm)))
)

(defrule ToNotWormLikeVisibleWithPermanentForm
   (Classification (ID ?x) (Class VisibleWithPremanentForm))
   (Description (ID ?x)(Features $?s WormLike No $?f))
   =>
   (assert (Classification (ID ?x)
           (Class NotWormLikeVisibleWithPermanentForm) (Flag 1)))
)

(defrule ToHuntingHorror
   (Classification (ID ?x) (Class WormLikeVisibleWithPermanentForm))
   (Description (ID ?x)(Features $?s Wings Yes $?f))
   =>
   (assert (Classification (ID ?x)
           (Class HuntingHorror) (Flag 1)))
)

(defrule ToWormLikeVisibleWithPermanentFormWithoutWings
   (Classification (ID ?x) (Class WormLikeVisibleWithPermanentForm))
   (Description (ID ?x)(Features $?s Wings No $?f))
   =>
   (assert (Classification (ID ?x)
           (Class WormLikeVisibleWithPermanentFormWithoutWings)))
)

(defrule ToChthonian
   (Classification (ID ?x) (Class WormLikeVisibleWithPermanentFormWithoutWings))
   (Description (ID ?x)(Features $?s Tentacles Yes $?f))
   =>
   (assert (Classification (ID ?x)
           (Class Chthonian) (Flag 1)))
)

(defrule ToDhole
   (Classification (ID ?x) (Class WormLikeVisibleWithPermanentFormWithoutWings))
   (Description (ID ?x)(Features $?s Tentacles No $?f))
   =>
   (assert (Classification (ID ?x)
           (Class Dhole) (Flag 1)))
)

(defrule Print
    (Classification (ID ?x) (Class ?y) (Flag 1))
    =>
    (printout t ?x " is a(n) " ?y crlf)
)