# Ruby object that represents a Javascript object
# and is used to proxy data
class ModelProxy
  class << self
    attr_accessor :session

    def js_attr_reader(*attributes)
      attributes.each do |attr|
        define_method attr do
          run_coffee <<-SCRIPT
              return #{assignment}.#{attr}
          SCRIPT
        end
      end
    end
  end

  def run_coffee(*arg)
    ModelProxy.session.run_coffee(*arg)
  end

  def initialize(attributes)
    script = "#{assignment} = new #{self.class.name}(\n"
    script += coffee_script_hash(attributes, indent: 2)
    script += ")\n"

    run_coffee script
  end

  def assignment
    "@objectSpace[\"#{js_object_id}\"]"
  end

  def js_object_id
    @js_object_id ||= create_js_object_id
  end

  private

  def coffee_script_hash(hash, indent:)
    hash.map do |key, value|
      value = value.to_s if value.is_a? Symbol
      (' ' * indent) + "#{key}: #{value.inspect}"
    end.join("\n") + "\n"
  end

  def create_js_object_id
    count = run_coffee <<-SCRIPT
      @objectSpace ||= {}
      @objectIdCounter ||= 0
      return @objectIdCounter += 1
    SCRIPT
    "object#{count}"
  end
end
