# Helpers to translate dutch names into
# english / ruby
module DutchHelpers
  # remap colors to english symbols
  def map_dutch_color_to_symbol(dutch_color)
    dutch_color = dutch_color[0...-1] if dutch_color[-1] == 'e'
    {
      'zwart' => :black,
      'blauw' => :blue,
      'paars' => :purple
    }[dutch_color]
  end
end

World(DutchHelpers)
