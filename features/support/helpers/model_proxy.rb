# Ruby object that represents a Javascript object
# and is used to proxy data
class ModelProxy
  class << self
    attr_accessor :session, :object_space

    def js_attr_reader(*attributes)
      attributes.each do |attr|
        define_method attr do
          run_coffee "return #{javascript_assignment}.#{attr}"
        end
      end
    end

    def assignment(attribute = nil)
      @assignment_attribute ||= attribute if attribute
      @assignment_attribute
    end
  end

  attr_reader :javascript_assignment

  def initialize(attributes = {})
    define_object_assignment(attributes)

    script = "#{javascript_assignment} = new #{javascript_class_name}(\n"
    script += coffee_script_hash(attributes, indent: 2)
    script += ")\n"

    run_coffee script
  end

  def method_missing(method_name, *args)
    self.class.send(:define_method,  method_name) do |*method_args|
      args = coffee_script_args(method_args)
      run_coffee <<-SCRIPT
        return #{javascript_assignment}.#{method_name}(#{args})
      SCRIPT
    end

    send(method_name, *args)
  end

  private

  # delegate method
  def run_coffee(*arg)
    ModelProxy.session.run_coffee(*arg)
  end

  def coffee_script_hash(hash, indent:)
    hash.map do |key, value|
      value = value.to_s if value.is_a? Symbol
      (' ' * indent) + "#{key}: #{value.inspect}"
    end.join("\n") + "\n"
  end

  # Convert ruby method arguments to coffee-script
  # arguments
  def coffee_script_args(arguments)
    arguments.map do |arg|
      arg.javascript_assignment if arg.respond_to? :javascript_assignment
    end.join ', '
  end

  def define_object_assignment(attributes)
    prepare_object_space
    object_name = "#{self.class.name.downcase}"
    attribute = self.class.assignment
    object_name += object_name_suffix(attributes[attribute]) if attribute

    @javascript_assignment = "#{object_space}['#{object_name}']"
  end

  def object_name_suffix(attribute)
    attribute.to_s.capitalize
  end

  def prepare_object_space
    run_coffee "#{object_space} ||= {}"
  end

  def object_space
    "#{ModelProxy.object_space}.objects"
  end

  def javascript_class_name
    "#{ModelProxy.object_space}.#{self.class.name}"
  end
end
