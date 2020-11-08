require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'Taxon show' do
  scenario 'displays full scientific classification' do
    given_a_full_taxon_hierarchy
    when_the_user_visits_a_species_page
    then_the_full_classification_is_displayed
  end
end

def when_the_user_visits_a_species_page
  @species = Taxon.where(rank: 'Species').first
  visit taxon_path(@species)
end

def then_the_full_classification_is_displayed
  parent_ranks = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus']
  classification_string = parent_ranks.join(' scientific name > ') + ' scientific name > Species scientific name'
  expect(page).to have_text "Scientific classification: #{classification_string}"
  parent_ranks.each { |rank|
    taxon = Taxon.where(rank: rank).first
    expect(page).to have_link taxon.scientific_name, href: taxon_path(taxon)
  }
end
