class BrowseController < ApplicationController

  QUANTITY = 5

  def index
    @animon_random = Animon.random_animons_with_picture(QUANTITY)
    @animon_latest = Animon.latest_animons_with_picture(QUANTITY)

    @phyla = {}
    Taxon.where(rank: 'Phylum').each do |p|
      @phyla[p] = Animon.random_animons_with_picture_in_taxon(QUANTITY, p)
    end
  end
end
