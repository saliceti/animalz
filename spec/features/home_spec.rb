require "rails_helper"

feature 'Home' do
  scenario 'Visit' do
    when_a_user_visits_the_home_page
    then_they_receive_greeting_message
    and_the_menus_are_displayed
  end
end

def when_a_user_visits_the_home_page
  visit root_path
end

def then_they_receive_greeting_message
  expect(page).to have_text('Welcome to our planet!')
end

def and_the_menus_are_displayed
  expect(page).to have_link('Home', href: root_path)
  expect(page).to have_link('Anidex', href: browse_index_path)
end
