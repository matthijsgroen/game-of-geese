# Helper methods to ease setting up the game
module GameHelpers
  def add_player(game, attributes)
    person_attributes = attributes.select { |k| [:name, :age].include? k }
    pawn_attributes = attributes.select { |k| [:color].include? k }

    person = Person.new person_attributes
    pawn = Pawn.new(pawn_attributes)

    game.join(person, pawn)
  end
end

World(GameHelpers)
