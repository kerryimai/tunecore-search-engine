require 'rails_helper'

RSpec.describe Album, :type => :model do
  context "album attributes validation" do
    it "is valid with valid attributes" do
      album = create(:album)
      expect(album).to be_valid
    end

    it "is not valid without a title" do
      artist = create(:artist)
      expect(Album.new(artist_id: artist.id)).to_not be_valid
    end

    it "is not valid without an artist" do
      expect(Album.new(title: "no good album")).to_not be_valid
    end
  end
end
