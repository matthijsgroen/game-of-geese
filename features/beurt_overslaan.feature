# language: nl
Functionaliteit: Een beurt overslaan
  Hotel: "Moe van de reis blijf je hier een nachtje slapen. Een beurt overslaan"
  Gevangenis: "Moet je nu ook nog de gevangenis in..?! Twee beurten overslaan!"

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Piet  | 14       | blauw      |
      | Klaas | 9        | paars      |
    En alle pionnen staan op het startvakje


  Scenario: Beurt overslaan
    Stel op het 4de vakje is een "hotel"
    En daar moet je 1 beurt overslaan
    Als Klaas 4 dobbelt
    En Piet 6 dobbelt
    Dan is Piet aan de beurt om te dobbelen


  Scenario: Iedereen moet een beurt overslaan
    Stel op het 4de vakje is een "motel"
    En daar moet je 1 beurt overslaan
    Als Klaas 4 dobbelt
    En Piet 4 dobbelt
    Dan is Klaas aan de beurt om te dobbelen


  Scenario: Meerdere beurten overslaan
    Stel op het 4de vakje is een "holiday inn"
    En daar moet je 2 beurten overslaan
    Als Klaas 4 dobbelt
    En Piet 6 dobbelt
    Dan is Piet weer aan de beurt om te dobbelen
    Als de beurt van Piet is geweest
    Dan is Piet weer aan de beurt om te dobbelen
    Als de beurt van Piet is geweest
    Dan is Klaas aan de beurt om te dobbelen

