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

(defrule D-IsVisible (declare (salience 10))
    (Classification (ID ?x) (Class Creature))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l IsVisible $?r)))
    =>
    (printout t ?x ": Is it visible (Yes/No)? > ")
    (bind ?IsVisible (read))
    (if (eq ?IsVisible Yes) then (modify ?d (Features $?y IsVisible Yes)))
    (if (eq ?IsVisible No) then (modify ?d (Features $?y IsVisible No)))
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

(defrule D-Sound (declare (salience 8))
    (Classification (ID ?x) (Class Invisible))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Sound $?r)))
    =>
    (printout t ?x ": What kind of sound does it make (1:Chuckle/2:HighPitchedWhistling)? > ")
    (bind ?Sound (read))
    (if (eq ?Sound 1) then (modify ?d (Features $?y Sound Chuckle)))
    (if (eq ?Sound 2) then (modify ?d (Features $?y Sound HighPitchedWhistling)))
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

(defrule D-PermanentForm (declare (salience 8))
    (Classification (ID ?x) (Class Visible))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l PermanentForm $?r)))
    =>
    (printout t ?x ": Does it have a permanent form (Yes/No/ManyForms)? > ")
    (bind ?PermanentForm (read))
    (if (eq ?PermanentForm Yes) then (modify ?d (Features $?y PermanentForm Yes)))
    (if (eq ?PermanentForm No) then (modify ?d (Features $?y PermanentForm No)))
    (if (eq ?PermanentForm ManyForms) then (modify ?d (Features $?y PermanentForm Many)))
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

(defrule D-WormLike (declare (salience 6))
    (Classification (ID ?x) (Class VisibleWithPremanentForm))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l WormLike $?r)))
    =>
    (printout t ?x ": Is it worm-like (Yes/No)? > ")
    (bind ?WormLike (read))
    (if (eq ?WormLike Yes) then (modify ?d (Features $?y WormLike Yes)))
    (if (eq ?WormLike No) then (modify ?d (Features $?y WormLike No)))
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

(defrule D-Wings (declare (salience 4))
    (Classification (ID ?x) (Class WormLikeVisibleWithPermanentForm))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Wings $?r)))
    =>
    (printout t ?x ": Has wings (Yes/No)? > ")
    (bind ?Wings (read))
    (if (eq ?Wings Yes) then (modify ?d (Features $?y Wings Yes)))
    (if (eq ?Wings No) then (modify ?d (Features $?y Wings No)))
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

(defrule D-Tentacles (declare (salience 2))
    (Classification (ID ?x) (Class WormLikeVisibleWithPermanentFormWithoutWings))  
    ?d <- (Description (ID ?x) (Features $?y))
    (not (Description (ID ?x) (Features $?l Tentacles $?r)))
    =>
    (printout t ?x ": Does it have tentacles (Yes/No)? > ")
    (bind ?Tentacles (read))
    (if (eq ?Tentacles Yes) then (modify ?d (Features $?y Tentacles Yes)))
    (if (eq ?Tentacles No) then (modify ?d (Features $?y Tentacles No)))
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

(defrule Print (declare (salience -1))
    (Classification (ID ?x) (Class ?y) (Flag 1))
    =>
    (printout t ?x " is a(n) " ?y crlf)
)  