# Helpers to translate dutch names into
# english / ruby
module DutchHelpers
  # remap colors to english symbols
  def map_dutch_color_to_symbol(dutch_color)
    {
      'zwart' => :black,
      'blauw' => :blue,
      'paars' => :purple,
      'geel'  => :yellow,
      'groen' => :green,
      'rood'  => :red,
      'wit'   => :white
    }[simplified_dutch_color dutch_color]
  end

  def simplified_dutch_color(dutch_color)
    return 'rood' if dutch_color == 'rode'
    return 'wit' if dutch_color == 'witte'
    return dutch_color[0...-1] if dutch_color[-1] == 'e'
    dutch_color
  end
end

World(DutchHelpers)
