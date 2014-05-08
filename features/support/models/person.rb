# Person that will play our game
class Person < ModelProxy
  assignment :name
  js_attr_reader :name, :age
end
