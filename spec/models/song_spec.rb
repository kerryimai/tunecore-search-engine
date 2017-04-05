require 'rails_helper'

RSpec.describe Song, :type => :model do

  context "Song attributes validation" do
    it "is valid with valid attributes" do
      song = create(:song)
      expect(song).to be_valid
    end

    it "is not valid without a song title" do
      album = create(:album)
      expect(Song.new(album_id: album.id)).to_not be_valid
    end
  end

  # def self.search(params)
  context "filters songs by params given" do
    it "returns all songs when no params given" do
      songs = create_list(:song, 20)
      expect(Song.search({})).to eq(songs)
    end

    it "returns only songs which include given word" do
      song1 = create(:song, song_title: "right one")
      song2 = create(:song, song_title: "also right")
      song3 = create(:song, song_title: "wrong one")
      result = Song.search({:song_title =>"right"})
      expect(result).to include(song1, song2)
      expect(result).to_not include(song3)
    end

    it "returns all songs from given album title" do
      album = create(:album, title: "Hello world")
      songs = create_list(:song, 8, album: album)
      create_list(:song, 6)
      result = Song.search({:title =>"hello"})
      expect(result.length).to eq(8)
      expect(result).to eq(songs)
    end

    it "returns all songs from given artist name" do
      artist = create(:artist, name: "right Singer")
      album = create(:album, artist: artist)
      songs = create_list(:song, 12, album: album)
      create_list(:song, 15)
      result = Song.search({:name =>"singer"})
      expect(result.length).to eq(12)
      expect(result.sort).to eq(songs.sort)
    end

    it "returns all songs from multiple params" do
      artist = create(:artist, name: "right Singer")
      album1 = create(:album, artist: artist, title: "Good title")
      album2 = create(:album, artist: artist)
      songs = create_list(:song, 8, album: album1, song_title: "Correct ones")
      create_list(:song, 4, album: album2)
      create_list(:song, 6)
      create_list(:song, 6, album: album1)

      result = Song.search({:name =>"right", :title => "good", :song_title => "correct"})
      expect(result.length).to eq(8)
      expect(result.sort).to eq(songs.sort)
    end

  end

end
