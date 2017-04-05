class SongsController < ApplicationController


  def index
    @songs = Song.search(params)
    respond_to do |format|
      format.html
      format.js
    end
  end

end
