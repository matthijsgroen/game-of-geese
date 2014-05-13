# More info at https://github.com/guard/guard#readme

guard 'cucumber', cli: '--profile wip' do
  watch(%r{^features/.+\.feature$})                     { 'features' }
  watch(%r{^features/support/.+$})                      { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { 'features' }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :rspec, cmd: 'bundle exec rspec --color' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { "spec" }
  watch(%r{^features/support/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
