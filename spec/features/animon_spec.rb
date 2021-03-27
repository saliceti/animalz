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
    and_edit_links_are_displayed
  end
  scenario 'Create with taxon' do
    given_a_full_taxon_hierarchy
    when_a_user_creates_an_animon_with_a_taxon
    then_the_new_taxon_details_are_displayed
  end
  scenario 'Edit' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_is_on_the_edit_form
    and_a_user_edits_an_animon
    then_it_is_updated
  end
  scenario 'Edit taxon link' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_is_on_the_edit_form
    then_there_is_a_link_to_edit_the_taxon
  end
  scenario 'Delete' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_deletes_an_animon
    then_the_animon_is_deleted
  end
  scenario 'Add twitter handle' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_adds_a_twitter_handle
    then_the_twitter_content_displayed
  end
  scenario 'Add profile picture' do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_adds_a_profile_picture
    then_the_picture_is_displayed
  end
  scenario "All animons" do
    given_many_animons
    when_the_user_visits_all_animons
    then_the_animons_are_listed_in_alphabetical_order
  end
  scenario 'Latest animons' do
    given_many_animons
    when_user_visits_latest_animons
    then_animons_are_listed_in_reverse_chronological_order
    and_the_title_is_latest_animons
  end

  def and_an_animon_is_linked_to_a_taxon
    species = Taxon.where(rank: 'Species').first
    @animon = Animon.new(taxon: species)
    @animon.save
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
    animon = Animon.first
    expect(page).to have_link 'Identity', href: taxon_path(animon.taxon)
    expect(page).not_to have_link 'Tweets by'
  end

  def and_edit_links_are_displayed
    id = current_path.split('/').last
    expect(page).to have_link 'Edit', href: edit_animon_path(id)
  end

  def when_a_user_is_on_the_edit_form
    visit edit_animon_path(@animon)
  end

  def and_a_user_edits_an_animon
    expect(page).to have_select('animon_taxon_id', selected: 'Species: Species common name')
    select 'Subspecies: Subspecies common name', from: 'animon_taxon_id'
    click_button 'commit'
  end

  def then_it_is_updated
    expect(page).to have_text 'Animon: Subspecies common name'
  end

  def then_there_is_a_link_to_edit_the_taxon
    expect(page).to have_link('Edit identity', href: edit_taxon_path(@animon.taxon))
  end

  def when_a_user_deletes_an_animon
    visit edit_animon_path(@animon)
    expect(page).to have_link('Delete animon', href: animon_path(@animon)){|l| l["data-method"] == "delete" }
  end

  def then_the_animon_is_deleted
    expect{cbdriver.delete animon_path(@animon)}.to change{Animon.count}.by -1
  end

  def when_a_user_adds_a_twitter_handle
    visit edit_animon_path(@animon)
    expect(page).to have_select('animon_taxon_id', selected: 'Species: Species common name')
    fill_in 'Twitter handle', with: 'speciestwitterhandle'
    click_button 'commit'
  end

  def then_the_twitter_content_displayed
    embed_link = "https://twitter.com/speciestwitterhandle"
    expect(page).to have_link 'Tweets by speciestwitterhandle', href: embed_link
  end

  def when_a_user_adds_a_profile_picture
    visit edit_animon_path(@animon)
    attach_file(Rails.root.join 'app/assets/images/animon.png')
    expect{click_button 'commit'}.to change(ActiveStorage::Attachment, :count).by(1)
  end

  def then_the_picture_is_displayed
    expect(page).to have_css("img[src*='animon.png']")
  end

  def when_a_user_creates_an_animon_with_a_taxon
    visit new_animon_path
    expect(page).to have_text 'Create your new animon'
    expect(page).to have_select('animon_taxon_attributes_parent_id', with_options: ['Genus: Genus common name', 'Species: Species common name'])
    select 'Species', from: 'animon_taxon_attributes_rank'
    fill_in 'Common name', with: 'New species common name'
    fill_in 'Scientific name', with: 'New species scientific name'
    select('Genus: Genus common name', from: 'animon_taxon_attributes_parent_id')
    expect{click_button('commit')}.to change(Animon, :count).by(1)
      .and change(Taxon, :count).by(1)
  end

  def then_the_new_taxon_details_are_displayed
    expect(page).to have_text 'Animon: New species common name'
    expect(page).to have_text 'Scientific name: New species scientific name'
    animon = Animon.first
    expect(page).to have_link 'Identity', href: taxon_path(animon.taxon)
  end

  def given_many_animons
    genus = create(:genus)
    10.times {
      species = create(:species)
      animon = create(:animon, taxon: species)
    }
  end

  def when_the_user_visits_all_animons
    visit animons_path
  end

  def then_the_animons_are_listed_in_alphabetical_order
    animon_ids = nil
    within('div', class: 'animon_list') do
      animon_ids = extract_animon_ids
    end
    expected_ids = Animon.joins(:taxon).all.order(:common_name).map{|a| a.id}
    expect(animon_ids).to eq(expected_ids)
  end

  def when_user_visits_latest_animons
    visit animons_path(list: "latest")
  end

  def then_animons_are_listed_in_reverse_chronological_order
    animon_ids = nil
    within('div', class: 'animon_list') do
      animon_ids = extract_animon_ids
    end
    expected_ids = Animon.all.reverse.map{|a| a.id}
    expect(animon_ids).to eq(expected_ids)
  end

  def and_the_title_is_latest_animons
    expect(page).to have_css('.animon-title', text: 'Latest animons')
  end

end
