# language: nl
Functionaliteit: Beurt volgorde

  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Jan   | 12       | zwart      |
      | Piet  | 9        | blauw      |
      | Klaas | 14       | paars      |
    En alle pionnen staan op het startvakje


  Scenario: Een speler die mag starten kiezen
    Dan is Piet aan de beurt om te dobbelen omdat hij de jongste speler is


  Scenario: Beurtvolgorde met de klok mee
    Als de beurt van Piet is geweest
    Dan is Klaas aan de beurt om te dobbelen
    Als de beurt van Klaas is geweest
    Dan is Jan aan de beurt om te dobbelen

