require 'active_record'
require 'faker'
require 'pry'

require_relative './models/artist'
require_relative './models/album'
require_relative './models/artist_tag'
require_relative './models/tag'
require_relative './models/track'

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
      t.string :title
      t.integer :year
      t.references :artist
      t.timestamps
    end

  puts '-------- Creating Tracks Table --------'

    create_table :tracks, force: true do |t|
      t.string :title
      t.integer :number
      t.references :album
      t.timestamps
    end

  puts '-------- Creating Tags Table --------'

    create_table :tags, force: true do |t|
      t.string :name
      t.timestamps
    end

  puts '-------- Creating Artists_Tags Table --------'

    create_table :artists_tags, force: true do |t|
      t.references :artist
      t.references :tag
      t.timestamps
    end


end

# Adding rows to my tables

puts '---------- Adding Artists ----------'

20.times do 
  Artist.create!(name: Faker::Music.band)
end

  
puts '---------- Adding Albums With user_id ----------'

20.times do
  Album.create!(title: Faker::Music.album, year: Faker::Number.between(1970, 2019), artist_id: Faker::Number.between(Artist.first.id, Artist.last.id))
end

puts '---------- Adding Albums With the Relationship ----------'

Artist.all.each do |artist|
  3.times do
    artist.albums.create!(title: Faker::Music.album, year: Faker::Number.between(1970, 2019))
  end
end

puts '---------- Adding Tracks  ----------'

Album.all.each do |album| 
  10.times do
    album.tracks.create!(title: Faker::Music::UmphreysMcgee.song, number: Faker::Number.between(1,10))
  end
end

puts '---------- Adding Tags ----------'

  30.times do
    Tag.create!(name: Faker::Lorem.word)
  end

puts '---------- Adding Artists_Tags ----------'

  50.times do 
    ArtistTag.create!(artist: Artist.all.sample, tag: Tag.all.sample )
  end

binding.pry

