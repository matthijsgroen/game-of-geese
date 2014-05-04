task build: [:build_haml]

task :build_haml do
  require 'pathname'
  p = Pathname.new 'dist'
  p.mkpath

  require 'haml'
  require 'haml/exec'
  Haml::Exec::Haml.new(['app/index.haml', 'dist/index.html']).parse
end

