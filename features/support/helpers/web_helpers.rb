# Helpers to make web takses easier
module WebHelpers
  require 'coffee-script'

  # To use CoffeeScript in your cucumber steps,
  # @example
  # >> value = run_coffee "return confirm 'continue?'"
  def run_coffee(coffee_script, options = {})
    compiled_script = CoffeeScript.compile(coffee_script)
    script_to_run = wrap_script_for_exceptions(compiled_script)
    puts script_to_run if options[:debug]

    result = page.evaluate_script(script_to_run)
    detect_js_exceptions!(compiled_script)

    result
  end

  private

  def wrap_script_for_exceptions(compiled_script)
    wrapper_script = <<-COFFEESCRIPT
      delete window['currentException']
      try
        return `#{compiled_script}`
      catch error
        window.currentException = error
    COFFEESCRIPT

    CoffeeScript.compile(wrapper_script)
  end

  def detect_js_exceptions!(compiled_script)
    detect_exception_script = <<-COFFEESCRIPT
      if (typeof window.currentException is "undefined")
        return false
      else
        return window.currentException.message
    COFFEESCRIPT

    exception_message = page.evaluate_script(
      CoffeeScript.compile(detect_exception_script)
    )
    exception_message && fail("#{exception_message} in:\n#{compiled_script}")
  end
end

World(WebHelpers)
