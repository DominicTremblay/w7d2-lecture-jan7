require 'active_record'
require 'faker'
require 'pry'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'labber',
  password: 'labber',
  database: 'w7d2_lecture'
)

ActiveRecord::Schema.define do

  puts '-------- Creating Artist Table --------'


  puts '-------- Creating Albums Table --------'

  puts '-------- Creating Tracks Table --------'

  puts '-------- Creating Tags Table --------'

  puts '-------- Creating Artists_Tags Table --------'
end

puts '---------- Adding Artists ----------'
  
puts '---------- Adding Albums With user_id ----------'
  
puts '---------- Adding Albums With the Relationship ----------'
  
puts '---------- Adding Tracks to Album ----------'
  

puts '---------- Adding Tags ----------'
  
puts '---------- Adding Artists_Tags ----------'


binding.pry

