namespace :build do
  task :app do
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
end

task build: ['build:app']
