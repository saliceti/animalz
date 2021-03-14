require "rails_helper"


feature 'Animon Points' do
  scenario 'New animon' do
    given_a_new_animon
    when_it_is_displayed
    then_points_is_default_value
  end
end

def given_a_new_animon
  @animon = create(:animon)
end

def when_it_is_displayed
  visit(animon_path(@animon))
end

def then_points_is_default_value
  expect(page).to have_text("Points: 0")
end
