Before do
  require 'rake'
  load File.expand_path('../../../tasks/build.rake', __FILE__)
  Rake::Task['build'].invoke

  visit 'dist/index.html'
  ModelProxy.session = self
end
