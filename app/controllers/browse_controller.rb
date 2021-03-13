class BrowseController < ApplicationController

  QUANTITY = 5
  LINK_CLASS = "ml-2 text-xl no-underline"

  def index
    @animons_in_view = []

    if (params.has_key? :taxon)
      parent_taxon = Taxon.find(params[:taxon])
      @animons_in_view << {
        class: 'animon_all',
        link: helpers.link_to("📖 All animons in #{parent_taxon.rank} #{parent_taxon.common_name}", animons_path(taxon: parent_taxon), class: LINK_CLASS),
        list: Animon.random_animons_with_picture_in_taxon(QUANTITY, parent_taxon)
      }
      @animons_in_view << {
        class: 'animon_latest',
        link: helpers.link_to("📖 Latest animons in #{parent_taxon.rank} #{parent_taxon.common_name}", animons_path(taxon: parent_taxon, list: :latest), class: LINK_CLASS),
        list: Animon.latest_animons_with_picture_in_taxon(QUANTITY, parent_taxon)
      }
      taxons = parent_taxon.children
      @animons_in_view.concat animons_in_taxons(taxons)
    else
      @animons_in_view << {
        class: 'animon_all',
        link: helpers.link_to("📖 All animons", animons_path, class: LINK_CLASS),
        list: Animon.random_animons_with_picture(QUANTITY)
      }
      @animons_in_view << {
        class: 'animon_latest',
        link: helpers.link_to("📖 Latest animons", animons_path(list: :latest), class: LINK_CLASS),
        list: Animon.latest_animons_with_picture(QUANTITY)
      }

      taxons = Taxon.where(rank: 'Phylum')
      @animons_in_view.concat animons_in_taxons(taxons)
    end
  end

  private

  def animons_in_taxons(taxons)
    animons_in_view = []
    taxons.each do |t|
      animons_in_view << {
        class: "taxon_#{t.id}",
        link: helpers.link_to("📖 #{t.rank}: #{t.common_name.capitalize}s", browse_index_path(taxon: t), class: LINK_CLASS),
        list: Animon.random_animons_with_picture_in_taxon(QUANTITY, t)
      }
    end
    animons_in_view
  end

end
