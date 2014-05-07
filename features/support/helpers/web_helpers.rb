# Helpers to make web takses easier
module WebHelpers
  require 'coffee-script'

  # To use CoffeeScript in your cucumber steps,
  # @example
  # >> value = run_coffee "return confirm 'continue?'"
  def run_coffee coffee_script, options = {}
    compiled_script = CoffeeScript.compile(coffee_script)

    wrapper_script = <<-COFFEESCRIPT
      delete window['currentException']
      try
        return `#{compiled_script}`
      catch error
        window.currentException = error
    COFFEESCRIPT

    script_to_run = CoffeeScript.compile(wrapper_script)
    puts script_to_run if options[:debug]

    result = page.evaluate_script(script_to_run)

    has_err_script = <<-COFFEESCRIPT
      if (typeof window.currentException is "undefined")
        return false
      else
        return window.currentException.message
    COFFEESCRIPT

    exception_message = page.evaluate_script(CoffeeScript.compile(has_err_script))
    exception_message && raise("#{exception_message} in:\n#{compiled_script}")

    result
  end

end

World(WebHelpers)
