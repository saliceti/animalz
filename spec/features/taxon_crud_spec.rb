require "rails_helper"

feature 'Taxon CRUD' do
  scenario 'Create a new taxon' do
    given_a_taxon_already_exists
    when_a_user_creates_a_child_taxon
    then_the_new_taxon_is_displayed
  end
  scenario 'List taxons' do
    given_a_taxon_already_exists
    when_a_user_visits_the_taxon_index
    then_the_new_taxon_is_listed
  end
  scenario 'Update taxon' do
    given_a_taxon_already_exists
    when_a_user_edits_the_taxon
    then_the_new_value_is_displayed
  end
  scenario 'Delete taxon' do
    given_a_taxon_already_exists
    when_a_user_deletes_the_taxon
    then_the_taxon_is_deleted
  end
  scenario 'Create child taxon' do
    given_a_taxon_already_exists
    when_a_user_clicks_new_child_taxon
    then_the_form_is_prepopulated
    and_a_the_child_taxon_can_be_created
  end
end

def given_a_taxon_already_exists
  @chordata = Taxon.create(rank: 'Phylum', common_name: 'Chordate', scientific_name: 'Chordata')
  @chordata.save
  expect(Taxon.any?).to be true
end

def when_a_user_creates_a_child_taxon
  visit new_taxon_path
  expect(page).to have_text 'Create new taxon'
  expect(page).to have_select('taxon_parent_id', with_options: ['Phylum: Chordate'])
  select 'Class', from: 'taxon_rank'
  fill_in 'Common name', with: 'Mammals'
  fill_in 'Scientific name', with: 'Mammalia'
  select('Phylum: Chordate', from: 'taxon_parent_id')
  click_button('commit')
end

def then_the_new_taxon_is_displayed
  expect(page).to have_text 'Taxon was successfully created'
  expect(page).to have_link('Class', href: taxons_path(rank: 'Class'))
  expect(page).to have_text 'Common name: Mammals'
  expect(page).to have_text 'Scientific name: Mammalia'
  id = current_path.split('/').last
  expect(page).to have_link 'Edit', href: edit_taxon_path(id)
end

def when_a_user_visits_the_taxon_index
  visit taxons_path
end

def then_the_new_taxon_is_listed
  expect(page).to have_link('Chordate')
  expect(page).to have_link('Chordata')
end

def when_a_user_edits_the_taxon
  visit taxons_path
  click_link('Chordate')
  click_link('Edit')
  expect(page).to have_field('taxon_common_name', type: 'text', with: 'Chordate')
  fill_in 'Common name', with: 'Chordate-NEW'
  click_button('commit')
end

def then_the_new_value_is_displayed
  expect(page).to have_text 'Taxon was successfully updated'
  expect(page).to have_text 'Common name: Chordate-NEW'
end

def when_a_user_deletes_the_taxon
  @taxon = Taxon.find_by common_name: 'Chordate'
  visit edit_taxon_path(@taxon)
  expect(page).to have_link('Delete taxon', href: taxon_path(@taxon)){|l| l["data-method"] == "delete" }
end

def then_the_taxon_is_deleted
  expect{cbdriver.delete taxon_path(@taxon)}.to change{Taxon.count}.by -1
end

def and_the_user_is_redirected_to_the_index
  expect(cbdriver.response).to be_redirect
  visit cbdriver.response.location

  expect(current_path).to eq(taxons_path)
end

def and_the_taxon_is_not_there
  expect(page).not_to have_text @taxon.common_name
end

def when_a_user_clicks_new_child_taxon
  visit taxon_path(@chordata)
  expect(page).to have_link 'New child taxon', href: new_taxon_path(readonly_parent_taxon: @chordata)
  click_link 'New child taxon'
end

def then_the_form_is_prepopulated
  expect(page).to have_field('taxon_parent_id', type: 'hidden', with: @chordata.id)
  expect(page).to have_link @chordata.common_name, href: taxon_path(@chordata)
end

def and_a_the_child_taxon_can_be_created
  fill_in 'Common name', with: 'Amphibian'
  fill_in 'Scientific name', with: 'Amphibia'
  select 'Class', from: 'taxon_rank'
  click_button 'commit'
  expect(page).to have_text 'Taxon was successfully created'
  expect(page).to have_text 'Common name: Amphibian'
  expect(page).to have_text 'Scientific classification: Chordata > Amphibia'
end

private

def cbdriver
  Capybara.current_session.driver
end
