# language: nl
Functionaliteit: Nogmaals dobbelen

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Klaas | 14       | paars      |
      | Piet  | 9        | blauw      |
    En alle pionnen staan op het startvakje


  Scenario: Nogmaals dobbelen
    Stel op het 6de vakje mag je nogmaals dobbelen
    Als Piet 6 dobbelt
    Dan is Piet weer aan de beurt om te dobbelen


  Scenario: Conditioneel nogmaals dobbelen met te hoge worp
    Stel op het 6de vakje mag je nogmaals dobbelen
    Maar alleen als je minder dan 4 had gegooid
    Als Piet 6 dobbelt
    Dan is Klaas aan de beurt om te dobbelen


  Scenario: Conditioneel nogmaals dobbelen met juiste worp
    Stel op het 6de vakje mag je nogmaals dobbelen
    Maar alleen als je minder dan 4 had gegooid
    En de blauwe pion staat op het 4de vakje
    Als Piet 2 dobbelt
    Dan is Piet weer aan de beurt om te dobbelen
