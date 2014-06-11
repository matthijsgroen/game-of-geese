require 'drb/drb'

Stel(/^Het spel is gestart$/) do
  spawn 'ruby game_of_geese.rb'
  sleep 1
  @remotegame = DRbObject.new_with_uri("druby://localhost:8787")
end

Stel(/^ik heb een gosu speelbord met (\d+) vakjes$/) do |space_count|
  @remotegame.create_board 63
  expect(@remotegame.spaces.length).to eq(63)
end