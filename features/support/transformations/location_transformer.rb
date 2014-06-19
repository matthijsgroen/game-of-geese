@space = /(?:op |)het \d+(?:de|ste) vakje|daar/

Transform(/(?:op |)het (\d+)(?:de|ste) vakje/) do |location|
  @current_location = location.to_i
end

Transform(/daar/) do |_arg|
  @current_location
end
