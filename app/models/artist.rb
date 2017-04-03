class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, :through => :albums
  has_many :releases
  has_many :ft_songs, through: :releases, source: :song


end
