load File.expand_path('../tasks/cucumber.rake', __FILE__)

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = %w(--backtrace --color)
end

task default: [:rubocop, :spec, :cucumber]
