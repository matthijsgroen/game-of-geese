# language: nl
Functionaliteit: Volledig speelbord

  Scenario: Flink potje ganzenborden
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Jan   | 12       | zwart      |
      | Piet  | 9        | blauw      |
      | Klaas | 14       | paars      |
    En op het 3de vakje is een bokkesprong
    En op het 6de vakje is een "brug"
    En daar mag je verder naar vakje 12
    En op het 15de vakje is een "vogelkooi"
    En daar moet je terug naar vakje 9
    En op het 19de vakje is een "hotel"
    En daar moet je 1 beurt overslaan
    En op het 26ste vakje mag je nogmaals dobbelen
    Maar alleen als je minder dan 3 had gegooid
    En op het 31ste vakje is een put
    En op het 39ste vakje is een "trap"
    En daar moet je terug naar vakje 33
    En op het 42ste vakje is een "doolhof"
    En daar moet je terug naar vakje 30
    En op het 52ste vakje is een "gevangenis"
    En daar moet je 2 beurten overslaan
    En op het 58ste vakje is een "kerkhof"
    En daar moet je terug naar vakje 1
    En de volgende vakjes zijn ganzenvakjes:
      | vakje |
      | 1     |
      | 5     |
      | 10    |
      | 23    |
      | 32    |
      | 41    |
      | 45    |
      | 54    |
      | 59    |
    En alle pionnen staan op het startvakje
    Als het hele potje is gespeeld
    Dan is er een winnaar bekend
    En wint deze een prijs!


