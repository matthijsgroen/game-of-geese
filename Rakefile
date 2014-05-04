require 'pathname'

task default: [:haml]

task :haml do
  p = Pathname.new 'dist'
  p.mkpath

  require 'haml'
  require 'haml/exec'
  Haml::Exec::Haml.new(['app/index.haml', 'dist/index.html']).parse!
end
