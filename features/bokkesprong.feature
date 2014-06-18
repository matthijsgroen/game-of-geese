# language: nl
Functionaliteit: Bokkesprong

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Klaas | 14       | paars      |
      | Jan   | 12       | zwart      |
      | Piet  | 9        | blauw      |
    En de pionnen staan als volgt opgesteld:
      | pion  | vakje |
      | paars | 42    |
      | zwart | 1     |
      | blauw | 8     |


  Abstract Scenario: Grote sprong
    Stel op het <bokkesprong vakje> vakje is een bokkesprong
    En <speler> is aan de beurt om te dobbelen
    Als <speler> 2 dobbelt
    Dan staat de <pion> pion op het <doel vakje> vakje

  Voorbeelden:
      | bokkesprong vakje | speler | pion   | doel vakje |
      | 3de               | Jan    | zwarte | 9de        |
      | 10de              | Piet   | blauwe | 43ste      |


  Scenario: Voorste speler op bokkesprong
    Stel op het 46ste vakje is een bokkesprong
    En Klaas is aan de beurt om te dobbelen
    Als Klaas 4 dobbelt
    Dan staat de paarse pion op het 46ste vakje

