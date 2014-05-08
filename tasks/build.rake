task build: [:build_haml]

task :build_haml do
  require 'pathname'
  p = Pathname.new 'dist'
  p.rmtree if p.exist?
  p.mkpath

  require 'sprockets'
  require 'tilt'

  environment = Sprockets::Environment.new
  environment.append_path 'app'

  asset = environment.find_asset('application')
  asset.write_to 'dist/application.js'

  index = Tilt.new('app/index.html.haml')
  File.open('dist/index.html', 'w') do |f|
    f.write index.render
  end
end
