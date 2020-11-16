require "rails_helper"

feature 'Help' do
  scenario 'Visit' do
    when_a_user_visits_the_help_page
  end
end

def when_a_user_visits_the_help_page
  visit help_index_path
end
