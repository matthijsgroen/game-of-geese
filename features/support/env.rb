root = File.dirname(__FILE__) + '/../../app/'

Dir["#{root}/**/*.rb"].each do |file|
  load file
end
