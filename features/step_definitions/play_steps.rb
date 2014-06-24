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
    add_player(game, player_attributes)
  end
end

Stel(/^(\w+) is aan de beurt om te dobbelen$/) do |player_name|
  while game.active_player.name != player_name
    game.active_player.play_turn(FixedDie.new(0))
  end
end

Stel(/^Piet gooit altijd (\d+) met de dobbelsteen$/) do |die_value|
  game.die = FixedDie.new(die_value)
end

Als(/^de beurt van (\w+) is geweest$/) do |player_name|
  until game.active_player.name == player_name
    game.active_player.play_turn(game.die)
  end
  game.active_player.play_turn(game.die)
end

Als(/^(\w+) (?:een ronde later |)(\d+) dobbelt$/) do |player_name, die_value|
  until game.active_player.name == player_name
    game.active_player.play_turn(game.die)
  end

  game.active_player.play_turn(FixedDie.new(die_value))
end

Als(/^er (\d+) speelrondes zijn gespeeld$/) do |round_count|
  round_count.times { game.play_round }
end

Dan(/^heeft (\w+) het spel gewonnen$/) do |player_name|
  expect(game.winner.name).to eql player_name
end

Dan(/^is (\w+) (?:weer |)aan de beurt om te dobbelen/) do |person_name|
  expect(game.active_player.name).to eql person_name
end
