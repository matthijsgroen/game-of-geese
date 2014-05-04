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
