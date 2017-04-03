# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

beyonce = Artist.create!(name: "Beyonce")
sia = Artist.create!(name: "Sia")
katy_perry = Artist.create!(name: "Katy Perry")
the_weekend = Artist.create!(name: "THe Weekend")

yonce = Album.create!(title: "yonce", artist_id: beyonce.id)
dream = Album.create!(title: "Dream girl", artist_id: beyonce.id)
lemonade = Album.create!(title: "lemonade", artist_id: beyonce.id)

b1 = Song.create!(song_title: "song1", album_id: yonce.id)
b2 = Song.create!(song_title: "song2", album_id: yonce.id)
b3 = Song.create!(song_title: "song3", album_id: yonce.id)
b4 = Song.create!(song_title: "song4", album_id: yonce.id)
b5 = Song.create!(song_title: "song5", album_id: lemonade.id)
b6 = Song.create!(song_title: "song6", album_id: lemonade.id)

b1.ft_artists << katy_perry
b1.ft_artists << sia
b3.ft_artists << katy_perry
b4.ft_artists << katy_perry
b6.ft_artists << the_weekend
b2.ft_artists << sia
b3.ft_artists << sia
b1.ft_artists << the_weekend
b5.ft_artists << the_weekend
