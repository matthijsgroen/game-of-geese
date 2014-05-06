# Person that will play our game
class Person < WebHelpers::ModelProxy
  def initialize(attributes)
    run_coffee <<-SCRIPT
      #{assignment} = new Person(
        name: #{attributes[:name].inspect}
        age: #{attributes[:age].inspect}
      )
    SCRIPT
  end

  def name
    run_coffee <<-SCRIPT
      return #{assignment}.name
    SCRIPT
  end

  def age
    run_coffee <<-SCRIPT
      return #{assignment}.age
    SCRIPT
  end
end
