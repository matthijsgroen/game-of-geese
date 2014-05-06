# Helpers to make web takses easier
module WebHelpers
  require 'coffee-script'

  # To use CoffeeScript in your cucumber steps,
  # @example
  # >> value = run_coffee "return confirm 'continue?'"
  def run_coffee(coffee_script)
    compiled_script = CoffeeScript.compile(coffee_script)
    page.evaluate_script(compiled_script)
  end

  # Ruby object that represents a Javascript object
  # and is used to proxy data
  class ModelProxy
    class << self
      attr_accessor :session
    end

    def run_coffee(*arg)
      ModelProxy.session.run_coffee(*arg)
    end

    def assignment
      "@objectSpace[\"#{js_object_id}\"]"
    end

    def js_object_id
      @js_object_id ||= create_js_object_id
    end

    private

    def create_js_object_id
      count = run_coffee <<-SCRIPT
        @objectSpace ||= {}
        @objectIdCounter ||= 0
        return @objectIdCounter += 1
      SCRIPT
      "object#{count}"
    end
  end
end

World(WebHelpers)
