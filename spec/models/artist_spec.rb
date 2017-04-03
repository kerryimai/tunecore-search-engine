require 'rails_helper'

RSpec.describe Artist, :type => :model do

  context "Artist attributes validation" do
    it "is valid with valid attributes" do
      expect(Artist.new(name: "Good Name")).to be_valid
    end

    it "is not valid without a name" do
      expect(Artist.new).to_not be_valid
    end
  end

  context "Artist can have featured songs" do
    it "returns featured songs of an artist" do
      songs = create_list(:song, 5)
      artist = create(:artist)
      artist.ft_songs.append(songs)
      expect(artist.ft_songs).to eq(songs)
      expect(songs.first.ft_artists.first).to eq(artist)
    end
  end

end
