require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'Animon CRUD' do
  scenario 'New displays available species and subspecies' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_clicks_the_new_animon_link
    then_it_shows_the_animon_form
    and_available_species_and_subspecies_are_displayed
  end
  scenario 'Create' do
    given_a_full_taxon_hierarchy
    when_a_user_creates_an_animon
    then_it_is_displayed
  end
end

def and_an_animon_is_linked_to_a_taxon
  species = Taxon.where(rank: 'Species').first
  animon = Animon.new(taxon: species)
  animon.save
end

def when_a_user_clicks_the_new_animon_link
  visit root_path
  click_on 'New animon'
end

def then_it_shows_the_animon_form
  expect(page).to have_text 'Create your new animon'
  expect(page).to have_css 'form'
end

def and_available_species_and_subspecies_are_displayed
  expect(page).to have_select('animon_taxon_id', options: ['', 'Subspecies: Subspecies common name'])
end

def when_a_user_creates_an_animon
  visit new_animon_path
  select 'Species: Species common name', from: 'animon_taxon_id'
  expect {click_button 'commit'}.to change{Animon.count}.by 1
end

def then_it_is_displayed
  expect(page).to have_text 'Animon: Species common name'
end
