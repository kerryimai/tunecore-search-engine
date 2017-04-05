# local seed data, uncomment to use  -----------------------------------

# beyonce = Artist.create!(name: "Beyonce")
# sia = Artist.create!(name: "Sia")
# katy_perry = Artist.create!(name: "Katy Perry")
# the_weekend = Artist.create!(name: "THe Weekend")
#
# yonce = Album.create!(title: "yonce", artist_id: beyonce.id)
# dream = Album.create!(title: "Dream girl", artist_id: beyonce.id)
# lemonade = Album.create!(title: "lemonade", artist_id: beyonce.id)
#
# b1 = Song.create!(song_title: "song1", album_id: yonce.id)
# b2 = Song.create!(song_title: "song2", album_id: yonce.id)
# b3 = Song.create!(song_title: "song3", album_id: yonce.id)
# b4 = Song.create!(song_title: "song4", album_id: yonce.id)
# b5 = Song.create!(song_title: "song5", album_id: lemonade.id)
# b6 = Song.create!(song_title: "song6", album_id: lemonade.id)
#
# b1.ft_artists << katy_perry
# b1.ft_artists << sia
# b3.ft_artists << katy_perry
# b4.ft_artists << katy_perry
# b6.ft_artists << the_weekend
# b2.ft_artists << sia
# b3.ft_artists << sia
# b1.ft_artists << the_weekend
# b5.ft_artists << the_weekend

# ---------------------------------------------------------

require 'open-uri'
require 'nokogiri'

def scrape_seeding
  scrape_artist("https://en.wikipedia.org/wiki/Beyonc%C3%A9")
  scrape_artist("https://en.wikipedia.org/wiki/Elton_John")
  scrape_artist("https://en.wikipedia.org/wiki/Michael_Jackson")
  scrape_artist("https://en.wikipedia.org/wiki/Eminem")
  scrape_artist("https://en.wikipedia.org/wiki/Bob_Marley")
  scrape_artist("https://en.wikipedia.org/wiki/Lil_Wayne")
  scrape_artist("https://en.wikipedia.org/wiki/Britney_Spears")
  scrape_artist("https://en.wikipedia.org/wiki/Jay_Z")

  p "Scraping success"
end

def scrape_artist(link)
  doc = Nokogiri::HTML(open(link))
  artist_text = doc.css('#firstHeading').text.capitalize
  disco = doc.css('h2:has(span#Discography) ~ ul').first
  list = disco.css('li a')
  artist = Artist.find_or_create_by(name: artist_text)
  list.each do |x|
    scrape_album("https://en.wikipedia.org" + x["href"], artist)
  end
end

def scrape_album(link, artist)
  doc = Nokogiri::HTML(open(link))
  album_text = doc.css('#firstHeading i').text.capitalize
  songs = doc.css('.tracklist:first-of-type>tr>td:nth-child(2)')
  songs.pop
  album = Album.find_or_create_by(title: album_text, artist: artist)
  songs.each do |song|
    feats = (song.text).delete("\"\(\)").gsub(/featuring/i, ",").gsub(/ and /i, ",").split(",")
    song_name = feats.shift
    new_song = Song.find_or_create_by(song_title: song_name.strip.capitalize, album: album)
    unless feats.empty?
      feats.map do |feat|
        new_song.ft_artists <<  Artist.find_or_create_by(name: feat.strip.capitalize)
      end
    end
  end
end

scrape_seeding
