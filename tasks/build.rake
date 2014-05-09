task :build do
  require 'pathname'
  p = Pathname.new 'dist'
  p.rmtree if p.exist?
  p.mkpath

  require 'tilt'

  index = Tilt.new('app/index.html.haml')
  File.open('dist/index.html', 'w') do |f|
    f.write index.render
  end

  require 'sprockets'
  environment = Sprockets::Environment.new
  environment.append_path 'app'

  asset = environment.find_asset('application')
  asset.write_to 'dist/application.js'
end

task :build_tests do
  require 'sprockets'
  environment = Sprockets::Environment.new
  environment.append_path 'spec/javascripts'

  asset = environment.find_asset('spec')
  asset.write_to 'spec/javascripts/all.js'
end
