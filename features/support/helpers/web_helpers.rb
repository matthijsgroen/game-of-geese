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
end

World(WebHelpers)
