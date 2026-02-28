%--------------------------------------------------------
tff(species_type,type,species: $tType ).
tff(foodlink_type,type,foodlink: $tType ).
tff(foodchain_type,type, foodchain: $tType ).
tff(eaten_type,type,eaten: foodlink > species ).
tff(eater_type,type, eater: foodlink > species ).
tff(eats_type,type,eats: (species * species) > $o ).
tff(apex_type,type,apex: species > $o ).
tff(primary_type,type,primary: species > $o ).
tff(depends_type,type,depends: (species * species) > $o ).
tff(start_type,type, start: foodchain > species ).
tff(end_type,type, end: foodchain > species ).
tff(complete_foodchain_type,type, complete_foodchain: foodchain > $o ).

%-Axiom--------------------------------------------------
tff(eater_link_eaten,axiom, ! [FL: foodlink] : eats(eater(FL), eaten(FL))).

%-Axiom--------------------------------------------------
tff(no_cannibalism,axiom, ! [FL: foodlink] : eaten(FL) != eater(FL)). 

%-Axiom--------------------------------------------------
tff(eats_or_eaten,axiom, ![S: species] : ((? [S2: species] : eats(S,S2)) | (? [S2: species] : eats(S2,S)))).

%-Axiom--------------------------------------------------
tff(is_primary,axiom, ! [S: species] : (primary(S) <=> ~ ? [S2: species] : eats(S,S2))).

%-Theorem------------------------------------------------
tff(primary_not_eater,conjecture, ! [S: species] : (primary(S) => ~ ? [FL: foodlink] : eater(FL) = S )).

%-Theorem------------------------------------------------
tff(primary_eaten,conjecture, ! [S: species] : (primary(S) => ? [S2: species] : eats(S2, S))).

%-Theorem------------------------------------------------
tff(non_primary_eats,conjecture, ! [S: species] : (~ primary(S) => ? [S2: species] : eats(S, S2 ))).

%-Axiom--------------------------------------------------
tff(apex_not_eaten,axiom, ! [S: species] : (apex(S) <=> ~ ? [S2: species] : eats(S2, S))).

%-Theorem------------------------------------------------
tff(apex_not_eaten_link,conjecture, ! [S: species] : (apex(S) => ~ ? [FL: foodlink] : eaten(FL) = S)).

%-Theorem------------------------------------------------
tff(apex_eats,conjecture, ! [S: species] : (apex(S) => ? [S2: species] : eats(S, S2))).

%-Theorem------------------------------------------------
tff(non_apex_eaten,conjecture, ! [S: species] : (~ apex(S) => ? [S2: species] : eats(S2, S))).

%-Axiom--------------------------------------------------
tff(foodchain_order,axiom, ! [FC: foodchain] : ? [FL: foodlink] : (eaten(FL) = start(FC) & ((eater(FL) = end(FC)) <~> (? [FC2: foodchain] : (start(FC2) = eater(FL) & end(FC2) = end(FC)))))).

%-Axiom--------------------------------------------------
tff(no_foodchain_back,axiom, ! [FC: foodchain] : start(FC) != end(FC)).

%-Axiom--------------------------------------------------
tff(fc_start_end,axiom, ! [FC: foodchain] : (complete_foodchain(FC) => (primary(start(FC)) & apex(end(FC))))).

%-Axiom--------------------------------------------------
tff(species_in_foodchain,axiom, ! [S: species] : ? [FC: foodchain] : (complete_foodchain(FC) & (start(FC) = S | end(FC) = S | ? [FC1: foodchain, FC2: foodchain] : (start(FC1) = start(FC) & end(FC1) = S & start(FC2) = S & end(FC2) = end(FC)) ))).

%-Theorem------------------------------------------------
tff(no_foodchain_loops,conjecture, ! [FC: foodchain] : (complete_foodchain(FC) => ~ eats(start(FC), end(FC))) ).

%-Theorem------------------------------------------------
tff(middle_of_foodchain,conjecture, ! [S: species] : ((~ primary(S) & ~ apex(S)) => ( (? [FC1: foodchain] : (primary(start(FC1)) & end(FC1) = S)) & (? [FC2: foodchain] : (start(FC2) = S & apex(end(FC2))))))).

%-Axiom--------------------------------------------------
tff(depends_on,axiom, ! [S: species, S2: species] : (depends(S, S2) <=> ? [FC: foodchain] : (start(FC) = S2 & end(FC) = S))).

%-Theorem------------------------------------------------
tff(non_apex_predator,conjecture, ! [S: species] : (~ apex(S) => ? [S2: species] : (apex(S2) & depends(S2, S)))).

%-Theorem------------------------------------------------
tff(apex_predator_depends,conjecture, ! [S: species, FC: foodchain] : ((apex(S) & complete_foodchain(FC) & end(FC) = S) => depends(S, start(FC)))).

%--------------------------------------------------------