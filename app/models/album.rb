class Album < ApplicationRecord
has_many :songs
belongs_to :artist
validates_presence_of :title




end
