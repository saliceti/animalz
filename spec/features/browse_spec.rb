require "rails_helper"

feature 'Browse' do
  scenario 'Visit' do
    when_a_user_visits_the_browse_page
    then_the_browse_title_is_displayed
  end
end

def when_a_user_visits_the_browse_page
  visit browse_index_path
end

def then_the_browse_title_is_displayed
  expect(page).to have_text('Browse all Animons')
end
