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
  scenario 'displays child taxons' do
    given_a_full_taxon_hierarchy
    and_a_family_with_2_subfamilies_and_1_genus_children
    when_the_user_visits_the_family_page
    then_the_2_child_taxons_are_displayed
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

def and_a_family_with_2_subfamilies_and_1_genus_children
  @family = Taxon.where(rank: 'Family').first
  @subfamily2 = Taxon.create(
    rank: 'Subfamily', parent: @family,
    common_name: 'Subfamily common name 2', scientific_name: 'Subfamily scientific name 2'
  )
  @subfamily2.save
  @genus2 = Taxon.create(
    rank: 'Genus', parent: @family,
    common_name: 'Genus common name 2', scientific_name: 'Genus scientific name 2'
  )
  @genus2.save
end

def when_the_user_visits_the_family_page
  visit taxon_path(@family)
end

def then_the_2_child_taxons_are_displayed
  expect(page).to have_text "Child taxons"
  subfamily1 = Taxon.where(scientific_name: 'Subfamily scientific name').first
  [subfamily1, @subfamily2, @genus2].each do |taxon|
    expect(page).to have_link taxon.common_name, href: taxon_path(taxon)
  end
end
