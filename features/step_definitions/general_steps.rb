Transform(/\d+/) do |number|
  number.to_i
end

space = /(?:op |)het \d+de vakje|daar/

Transform(/(?:op |)het (\d+)de vakje/) do |location|
  @current_location = location.to_i
end

Transform(/daar/) do |_arg|
  @current_location
end

[:current_location, :game].each do |reader|
  define_method(reader) do
    instance_variable_get("@#{reader}")
  end
end

Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |space_count|
  @game = Game.new
  game.board = Board.new(space_count)
  game.die = Die.new
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
    add_player(game, player_attributes)
  end
end

Stel(/^alle pionnen staan op het startvakje$/) do
  # No assertion at the moment that requires implementation here
end

Als(/^de beurt van (\w+) is geweest$/) do |player_name|
  until game.active_player.name == player_name
    game.active_player.play_turn(game.die)
  end
  game.active_player.play_turn(game.die)
end

Dan(/^is (\w+) (?:weer |)aan de beurt om te dobbelen/) do |person_name|
  expect(game.active_player.name).to eql person_name
end

Als(/^(\w+) (\d+) dobbelt$/) do |player_name, die_value|
  until game.active_player.name == player_name
    game.active_player.play_turn(game.die)
  end

  game.active_player.play_turn(FixedDie.new(die_value))
end

Dan(/^staat de (\w+) pion (#{space})$/) do |dutch_color, location|
  pawn_color = map_dutch_color_to_symbol(dutch_color)

  pawn = game.pawns.find { |p| p.color == pawn_color }
  expect(pawn.location).to eql location
end

Dan(/^is de bord opstelling als volgt:$/) do |table|
  # table is a Cucumber::Ast::Table
  #  | pion  | vakje |

  table.map_headers!(
    'pion'  => :color,
    'vakje' => :location
  )
  table.map_column!('vakje') { |location| location.to_i }
  table.map_column!('pion') do |dutch_color|
    map_dutch_color_to_symbol(dutch_color)
  end

  expected_pawn_setup = Hash[
    table.hashes.map { |e| [e[:color], e[:location]] }
  ]

  actual_pawn_setup = Hash[
    game.pawns.map { |a| [a.color, a.location] }
  ]

  expect(actual_pawn_setup).to eql expected_pawn_setup
end

Stel(/^Piet gooit altijd (\d+) met de dobbelsteen$/) do |die_value|
  game.die = FixedDie.new(die_value)
end

Als(/^er (\d+) speelrondes zijn gespeeld$/) do |round_count|
  round_count.times { game.play_round }
end

Dan(/^heeft (\w+) het spel gewonnen$/) do |player_name|
  expect(game.winner.name).to eql player_name
end

Stel(/^(#{space}) is een ganzenvakje$/) do |location|
  game.set_rules_for_space(Rules::GooseSpace.new, location)
end

Stel(/^(#{space}) mag je nogmaals dobbelen$/) do |location|
  game.set_rules_for_space(Rules::RollAgain.new, location)
end

Stel(/^alleen als je minder dan (\d+) had gegooid$/) do |die_value|
  rules = game.get_rules_for_space(current_location)
  rules.max_die_value = die_value - 1
end

Stel(/^de (\w+) pion staat (#{space})$/) do |dutch_pawn_color, location|
  pawn_color = map_dutch_color_to_symbol(dutch_pawn_color)
  pawn = game.pawns.find { |p| p.color == pawn_color }
  pawn.location = location
end

Dan(/^de pionnen staan als volgt opgesteld:$/) do |table|
  # table is a Cucumber::Ast::Table
  #  | pion  | vakje |

  table.map_headers!(
      'pion'  => :color,
      'vakje' => :location
  )
  table.map_column!('vakje') { |location| location.to_i }
  table.map_column!('pion') do |dutch_color|
    map_dutch_color_to_symbol(dutch_color)
  end

  table.hashes.each do |data|
    pawn = game.pawns.find { |p| p.color == data[:color] }
    pawn.location = data[:location]
  end
end

Stel(/^(#{space}) is een "(.*?)"$/) do |location, label|
  game.board.set_label_for_space(label, location)
end

Stel(/^(#{space}) (?:mag|moet) je (?:verder |terug |)naar vakje (\d+)$/) \
  do |location, destination|
  game.set_rules_for_space Rules::GotoSpace.new(destination), location
end

Stel(/^(\w+) is aan de beurt om te dobbelen$/) do |player_name|
  while game.active_player.name != player_name
    game.active_player.play_turn(game.die)
  end
end
