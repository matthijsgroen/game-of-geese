root = File.dirname(__FILE__) + '/../../app/'

[:space, :current_location, :game].each do |reader|
  define_method(reader) do
    instance_variable_get("@#{reader}")
  end
end

Dir["#{root}/**/*.rb"].each do |file|
  load file
end
