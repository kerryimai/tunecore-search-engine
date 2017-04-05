class Song < ApplicationRecord
  belongs_to :album
  has_one :artist, through: :album
  has_many :releases
  has_many :ft_artists, through: :releases, source: :artist
  validates_presence_of :song_title


  def self.search(params)

    title = params[:title]
    song_title = params[:song_title]
    name = params[:name]
    query = all.includes(:album, :artist, :releases, :ft_artists)
    query = where('song_title ilike ?', "%#{song_title}%").includes(:album, :artist) if song_title.present?
    query = query.where('albums.title ilike ?', "%#{title}%").references(:album) if title.present?
    query = query.where('artists.name ilike ?', "%#{name}%").references(:artist) if name.present?
    query.to_a
  end
end
