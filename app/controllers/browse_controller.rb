class BrowseController < ApplicationController

  QUANTITY = 5

  def index
    @animon_random = Animon.random_animons_with_picture(QUANTITY)
  end
end
