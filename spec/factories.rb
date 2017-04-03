FactoryGirl.define do
  factory :artist do
    name "Taylor Swift"
  end

  factory :album do
    title "1989"
    artist
  end

  factory :song do
    song_title "blank space"
    album
  end

end
