# Helpers to translate dutch names into
# english / ruby
module DutchHelpers
  def map_dutch_color_to_symbol(dutch_color)
    # remap colors to english symbols
    {
      'zwart' => :black,
      'blauw' => :blue,
      'paars' => :purple
    }[dutch_color]
  end
end

World(DutchHelpers)
