Stel(/^ik heb een speelbord met (?:\d+) vakjes$/) do
  # No assertion yet that requires the amount
  # of spaces
  @game = Game.new
end

Stel(/^ik heb de volgende spelers met de klok mee:$/) do |table|
  # table is a Cucumber::Ast::Table
  # Table structure:
  # | naam  | leeftijd | kleur pion |
  # | Jan   | 12       | zwart      |
  table.map_headers!(
    'naam'       => :name,
    'leeftijd'   => :age,
    'kleur pion' => :color
  )
  table.map_column!('leeftijd') { |age| age.to_i }
  table.map_column!('kleur pion') do |dutch_color|
    map_dutch_color_to_symbol(dutch_color)
  end

  table.hashes.each do |player_attributes|
    add_player(@game, player_attributes)
  end
end

Stel(/^alle pionnen staan op het startvakje$/) do
  # No assertion at the moment that requires implementation here
end

Als(/^de beurt van (?:\w+) is geweest$/) do
  @game.play_turn
end

Dan(/^is (\w+) aan de beurt om te dobbelen/) do |name|
  expect(@game.active_player.name).to eql name
end

Als(/^Piet (\d+) dobbelt$/) do |arg1|
end

Dan(/^staat de (\w+) pion op het (\d+)de vakje$/) do |dutch_color, space_no|
  pawn_color = map_dutch_color_to_symbol(dutch_color)

  pawn = @game.pawns.find { |p| p.color == pawn_color }
  expect(pawn.location).to eql space_no
end

Als(/^Klaas (\d+) dobbelt$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dan(/^is de bord opstelling als volgt:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Stel(/^Piet gooit altijd (\d+) met de dobbelsteen$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Als(/^er (\d+) speelrondes zijn gespeeld$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dan(/^heeft Piet het spel gewonnen$/) do
  pending # express the regexp above with the code you wish you had
end

Stel(/^het (\d+)de vakje is een ganzenvakje$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

