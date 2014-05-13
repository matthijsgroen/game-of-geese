support_folders = %w(models roles)
support_root = File.dirname(__FILE__) + '/../features/support/'

support_folders.each do |folder|
  Dir["#{support_root}#{folder}/**/*.rb"].each do |file|
    load file
  end
end
