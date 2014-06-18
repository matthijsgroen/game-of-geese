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

Stel(/^(#{space}) is een "(.*?)"$/) do |location, label|
  game.board.set_label_for_space(label, location)
end

Stel(/^(#{space}) (?:mag|moet) je (?:verder |terug |)naar vakje (\d+)$/) \
  do |location, destination|
  game.set_rules_for_space Rules::GotoSpace.new(destination), location
end

Stel(/^(#{space}) moet je (\d+) (?:beurt|beurten) overslaan$/) \
  do |location, turns_to_skip|
  game.set_rules_for_space Rules::SkipTurn.new(turns_to_skip), location
end

Stel(/^(#{space}) is een bokkesprong$/) do |location|
  pending
end
