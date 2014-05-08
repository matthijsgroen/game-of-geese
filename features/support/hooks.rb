require 'rake'
load File.expand_path('../../../tasks/build.rake', __FILE__)
Rake::Task['build'].invoke

Before do
  visit 'dist/index.html'
  ModelProxy.session = self
end
