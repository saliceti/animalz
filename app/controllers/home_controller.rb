class HomeController < ApplicationController
  def index
    sample = 5
    total = 10
    @latest_contents = []

    latest_taxons = Taxon.latest_created(sample)
    latest_taxons.each{ |t|
      content = ''.html_safe
      content << "New #{t.rank}: "
      content << helpers.link_to(t.common_name, helpers.taxon_path(t))
      @latest_contents << content
    }
  end
end
