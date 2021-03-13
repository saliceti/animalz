module Helpers

  def given_a_full_taxon_hierarchy
    parent_taxon = nil
    Taxon::RANKS.each do |rank|
      taxon = Taxon.create(rank: rank, common_name: "#{rank} common name", scientific_name: "#{rank} scientific name", parent: parent_taxon)
      expect(taxon.save).to be true
      parent_taxon = taxon
    end
  end

  def cbdriver
    Capybara.current_session.driver
  end

  def extract_animon_ids
    page.all(:css, 'a').filter_map{ |a|
      if (!a.text.blank? && a[:href].starts_with?(animons_path) )
        a[:href].delete_prefix("#{animons_path}/").to_i
      end
    }
  end

end
