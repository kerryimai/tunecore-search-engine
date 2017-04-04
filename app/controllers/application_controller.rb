class ApplicationController < ActionController::Base
  require 'open-uri'
  require 'nokogiri'
  protect_from_forgery with: :exception

  def scrape_reddit
    scrape_artist("https://en.wikipedia.org/wiki/Beyonc%C3%A9")
    scrape_artist("https://en.wikipedia.org/wiki/Elton_John")
    scrape_artist("https://en.wikipedia.org/wiki/Michael_Jackson")
    scrape_artist("https://en.wikipedia.org/wiki/Eminem")
    scrape_artist("https://en.wikipedia.org/wiki/Bob_Marley")
    scrape_artist("https://en.wikipedia.org/wiki/Lil_Wayne")
    scrape_artist("https://en.wikipedia.org/wiki/Britney_Spears")
    scrape_artist("https://en.wikipedia.org/wiki/Jay_Z")

    render text: "Scraping Success!"
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

end
