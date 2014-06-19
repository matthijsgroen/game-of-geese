require 'drb/drb'

Stel(/^Het spel is gestart$/) do
  spawn 'ruby game_of_geese.rb'
  sleep 1
  @remotegame = DRbObject.new_with_uri('druby://localhost:8787')
end

Stel(/^ik heb een gosu speelbord met (\d+) vakjes$/) do |space_count|
  @game = Game.new
  @remotegame.update = true
  @remotegame.create_board space_count
  @remotegame.game = @game
  expect(@remotegame.spaces.length).to eq(space_count)
end

When(/^na (\d+) seconden voeg ik een speler toe$/) do |s|
  sleep s
  @remotegame.update = true
  @game.players << Person.new(name: 'jan', age: 10)
  @remotegame.game = @game
end