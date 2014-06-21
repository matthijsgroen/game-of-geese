# language: nl
Functionaliteit: De put
  "Je bent in de put gevallen. Je mag pas verder als je 6 gooit"

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Jan   | 12       | zwart      |
      | Piet  | 9        | blauw      |
      | Klaas | 14       | paars      |
    En alle pionnen staan op het startvakje


  Abstract Scenario: In de put vallen
    Stel op het 4de vakje is een put
    En Piet is aan de beurt om te dobbelen
    Als Piet 4 dobbelt
    En Piet een ronde later <worp> dobbelt
    Dan staat de blauwe pion op het 4de vakje

  Voorbeelden:
    | worp |
    | 1    |
    | 2    |
    | 3    |
    | 4    |
    | 5    |


  Scenario: Uit de put komen
    Stel op het 4de vakje is een put
    En Piet is aan de beurt om te dobbelen
    Als Piet 4 dobbelt
    En Piet een ronde later 6 dobbelt
    Dan staat de blauwe pion op het 10de vakje

