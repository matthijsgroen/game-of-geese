require_relative '../../lib/gosu-formatter/formatter'

AfterStep do
  formatter = Cucumber::Formatter::Demo
  formatter.update_game(@game) if formatter.active && @game
end
