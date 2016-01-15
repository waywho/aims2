# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:dm] = "%d %B"
Time::DATE_FORMATS[:dmy] = "%d %B, %Y"
Time::DATE_FORMATS[:numerals] = "%Y-%m-%d"