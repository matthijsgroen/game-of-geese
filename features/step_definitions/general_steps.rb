Stel(/^ik heb een speelbord met (?:\d+) vakjes$/) do
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

def map_dutch_color_to_symbol(dutch_color)
  # remap colors to english symbols
  {
    'zwart' => :black,
    'blauw' => :blue,
    'paars' => :purple
  }[dutch_color]
end

def add_player(game, attributes)
  person_attributes = attributes.select { |k| [:name, :age].include? k }
  pawn_attributes = attributes.select { |k| [:color].include? k }

  person = Person.new person_attributes
  pawn = Pawn.new(pawn_attributes)

  game.join(person, pawn)
end

# Person that will play our game
class Person
  def initialize(_attributes)
  end
end

# A physical pawn on the playing field
class Pawn
  def initialize(_attributes)
  end
end

# Our 'concept' of the game, maintaining the rules of the game
class Game
  def initialize
    @players = []
  end

  def join(person, pawn)
    player = person.extend Player
    player.pawn = pawn
    @players.push player
  end
end

# The role of a person playing game of goose
module Player
  attr_accessor :pawn
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
