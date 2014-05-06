# Person that will play our game
class Person < WebHelpers::ModelProxy
  js_attr_reader :name, :age

  def initialize(attributes)
    run_coffee <<-SCRIPT
      #{assignment} = new Person(
        name: #{attributes[:name].inspect}
        age: #{attributes[:age].inspect}
      )
    SCRIPT
  end
end
