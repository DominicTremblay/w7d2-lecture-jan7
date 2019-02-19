require 'active_record'
require 'faker'
require 'pry'

require_relative './models/artist'
require_relative './models/album'
require_relative './models/track'
require_relative './models/tag'
require_relative './models/artist_tag'


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

  create_table :artists, force: true do |t|
    t.string :name, null: false
    t.timestamps
  end

  puts '-------- Creating Albums Table --------'
  create_table :albums, force: true do |t|
    t.string :title, null: false
    t.integer :year, null: false
    t.references :artist
    t.timestamps
  end

  puts '-------- Creating Tracks Table --------'
  create_table :tracks, force: true do |t|
    t.string :title, null: false
    t.integer :number, null: false
    t.references :album
    t.timestamps
  end

  puts '-------- Creating Tags Table --------'
  create_table :tags, force: true do |t|
    t.string :name, null: false
    t.timestamps
  end

  puts '-------- Creating Artists_Tags Table --------'
  create_table :artists_tags, force: true do |t|
    t.references :artist
    t.references :tag
    t.timestamps
  end
end

  puts '---------- Adding Artists ----------'
  10.times do 
    Artist.create!(name: Faker::Music.band)
  end

  puts '---------- Adding Albums With user_id ----------'
  10.times do
    Album.create!(title: Faker::Music.album, year: Faker::Number.between(1970, 2019), artist: Artist.all.sample)
  end

  puts '---------- Adding Albums With the Relationship ----------'
  Artist.all.each do | artist |
    artist.albums.create!(title: Faker::Music.album, year: Faker::Number.between(1970, 2019))
  end

  puts '---------- Adding Tracks to Album ----------'
  Album.all.each do |album|
    rand(5..10).times do
      Track.create!(title: Faker::Music::UmphreysMcgee.song, number: rand(1..10), album: album)
    end
  end

puts '---------- Adding Tags ----------'
  30.times do
    Tag.create!(name: Faker::Verb.base)
  end

puts '---------- Adding Artists_Tags ----------'

30.times do
  artist = Artist.all.sample
  tag = Tag.all.sample
  artist.tags << tag
end

binding.pry

