Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
end

Stel(/^ik heb de volgende spelers met de klok mee:$/) do |table|
  # table is a Cucumber::Ast::Table
  #| naam  | leeftijd | kleur pion |
  #| Jan   | 12       | zwart      |
  table.map_headers!(
    'naam'       => :name,
    'leeftijd'   => :age,
    'kleur pion' => :pawn_color
  )

  table.hashes.each do |player_attributes|
    puts player_attributes.inspect
  end

  #pending # express the regexp above with the code you wish you had
end

Stel(/^alle pionnen staan op het startvakje$/) do
  pending # express the regexp above with the code you wish you had
end

Dan(/^is Piet aan de beurt om te dobbelen omdat hij de jongste speler is$/) do
  pending # express the regexp above with the code you wish you had
end

Als(/^de beurt van Piet is geweest$/) do
  pending # express the regexp above with the code you wish you had
end

Dan(/^is Klaas aan de beurt om te dobbelen$/) do
  pending # express the regexp above with the code you wish you had
end

Als(/^de beurt van Klaas is geweest$/) do
  pending # express the regexp above with the code you wish you had
end

Dan(/^is Jan aan de beurt om te dobbelen$/) do
  pending # express the regexp above with the code you wish you had
end
