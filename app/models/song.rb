class Song < ApplicationRecord
  belongs_to :album
  has_one :artist, through: :album
  has_many :releases
  has_many :ft_artists, through: :releases, source: :artist

end
