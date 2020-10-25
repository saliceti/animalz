require "rails_helper"

feature 'Home' do
  scenario 'Visit' do
    when_a_user_visits_the_home_page
    then_they_receive_greeting_message
  end
end

def when_a_user_visits_the_home_page
  visit root_path
end

def then_they_receive_greeting_message
  expect(page).to have_text('Welcome to our planet!')
end
