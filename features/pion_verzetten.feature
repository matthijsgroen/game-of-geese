# language: nl
Functionaliteit: Pion verzetten

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Klaas | 14       | blauw      |
      | Piet  | 9        | paars      |
    En alle pionnen staan op het startvakje


  Abstract Scenario: Vakjes lopen
    Als Piet <x> dobbelt
    Dan staat de paarse pion op het <x>de vakje
    Als de beurt van Klaas is geweest
    En Piet <y> dobbelt
    Dan staat de paarse pion op het <z>de vakje

  Voorbeelden:
      | x | y | z |
      | 2 | 3 | 5 |
      | 3 | 4 | 7 |
      | 6 | 2 | 8 |


  Scenario: Meerdere spelers op hetzelfde vak
    Als Piet 4 dobbelt
    Dan staat de paarse pion op het 4de vakje
    Als Klaas 4 dobbelt
    Dan is de bord opstelling als volgt:
      | pion  | vakje |
      | paars | 4     |
      | blauw | 4     |


  Scenario: Spel winnen
    Stel Piet gooit altijd 6 met de dobbelsteen
    Als er 11 speelrondes zijn gespeeld
    Dan heeft Piet het spel gewonnen


  Abstract Scenario: Ganzen vakjes
    Stel het <x>de vakje is een ganzenvakje
    Als Piet <x> dobbelt
    Dan staat de paarse pion op het <y>de vakje

  Voorbeelden:
      | x | y  |
      | 1 | 2  |
      | 2 | 4  |
      | 6 | 12 |
