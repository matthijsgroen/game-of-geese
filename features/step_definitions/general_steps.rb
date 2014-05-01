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

# Person that will play our game
class Person
  attr_reader :name, :age

  def initialize(attributes)
    @name = attributes[:name]
    @age = attributes[:age]
  end
end

# A physical pawn on the playing field
class Pawn
  def initialize(_attributes)
  end
end

# Our 'concept' of the game, maintaining the rules of the game
class Game
  attr_reader :players

  def initialize
    @players = []
  end

  def join(person, pawn)
    player = person.extend Player
    player.pawn = pawn
    @players.push player
  end

  # method name suggestion from:
  # http://english.stackexchange.com/questions/117734
  def active_player
    # the youngest player may start
    @players.sort do |a, b|
      a.age <=> b.age
    end.first
  end
end

# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  def turn?
    true
  end
end

Stel(/^alle pionnen staan op het startvakje$/) do
  # No assertion at the moment that requires implementation here
end

Dan(/^is Piet aan de beurt om te dobbelen omdat hij de jongste speler is$/) do
  expect(@game.active_player.name).to eql 'Piet'
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
