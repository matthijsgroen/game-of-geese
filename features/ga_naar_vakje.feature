# language: nl
Functionaliteit: Ga naar vakje
  Brug: "Je kunt de rivier oversteken. Ga verder naar X"
  Vogelkooi: "Er is een vogel weggevlogen. Om hem te vangen moet je terug naar X"
  Trap: "Domoor! Je bent van de trap gevallen, ga terug naar vakje X"
  Doolhof: "Nu ben je ook nog in het doolhof verdwaald. Ga terug naar vak X"
  Kerkhof: "Eigenlijk is je leven ten einde, maar je krijgt een nieuwe kans. Begin opnieuw op vak 1"


  Achtergrond:
    Stel ik heb een speelbord met 63 vakjes
    En ik heb de volgende spelers met de klok mee:
      | naam  | leeftijd | kleur pion |
      | Jan   | 12       | zwart      |
      | Piet  | 9        | blauw      |
      | Klaas | 14       | paars      |
    En de pionnen staan als volgt opgesteld:
      | pion  | vakje |
      | zwart | 5     |
      | blauw | 8     |
      | paars | 12    |


  Scenario: Verplaatsen naar voren
    Stel op het 6de vakje is een "brug"
    En daar mag je verder naar vakje 15
    En Jan is aan de beurt om te dobbelen
    Als Jan 1 dobbelt
    Dan staat de zwarte pion op het 15de vakje


  Scenario: Verplaatsen naar achteren
    Stel op het 14de vakje is een "vogelkooi"
    En daar moet je terug naar vakje 9
    En Klaas is aan de beurt om te dobbelen
    Als Klaas 2 dobbelt
    Dan staat de paarse pion op het 9de vakje


  @wip
  Scenario: Dubbele verplaatsing
    Stel op het 14de vakje mag je naar vakje 9
    En op het 9de vakje mag je naar vakje 16
    En Klaas is aan de beurt om te dobbelen
    Als Klaas 2 dobbelt
    Dan staat de paarse pion op het 16de vakje


  @todo
  Scenario: Handeling op doelvakje
    Stel op het 14de vakje mag je naar vakje 9
    En op het 9de vakje mag je nogmaals dobbelen
    Maar alleen als je minder dan 4 had gegooid
    En Klaas is aan de beurt om te dobbelen
    Als Klaas 2 dobbelt
    Dan staat de paarse pion op het 9de vakje
    En is Klaas weer aan de beurt om te dobbelen
