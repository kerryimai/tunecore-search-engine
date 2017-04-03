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

end
