Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |space_count|
  @game = Game.new
  game.board = Board.new(space_count)
  game.die = Die.new
end

Stel(/^alle pionnen staan op het startvakje$/) do
  # No assertion at the moment that requires implementation here
end

Stel(/^de (\w+) pion staat (#{space})$/) do |dutch_pawn_color, location|
  pawn_color = map_dutch_color_to_symbol(dutch_pawn_color)
  pawn = game.pawns.find { |p| p.color == pawn_color }
  pawn.location = location
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
