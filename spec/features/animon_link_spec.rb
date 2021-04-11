require "rails_helper"

feature 'Animon link' do
  scenario 'Add' do
    given_an_animon_exists
    when_a_user_visits_the_animon
    and_clicks_on_add_link
    and_adds_a_link
    then_the_link_is_displayed
  end

  def given_an_animon_exists
    @animon = create(:animon)
  end

  def when_a_user_visits_the_animon
    visit animon_path(@animon)
  end

  def and_clicks_on_add_link
    click_link "Add link"
  end

  def and_adds_a_link
    expect(page).to have_text "Add link to #{@animon.taxon.common_name}"
    expect(page).to have_field "animon_link_animon_id", with: @animon.id, type: :hidden

    @url = "https://www.montclairlocal.news/2021/04/01/the-red-fox-montclairs-cutest-carnivore-whats-in-your-backyard/"
    @title = "The red fox: montclair’s cutest carnivore (what’s in your backyard)"
    fill_in :animon_link_url, with: @url
    fill_in :animon_link_title, with: @title
    click_button 'commit'
  end

  def then_the_link_is_displayed
    expect(current_path).to eq(animon_path(@animon))
    expect(page).to have_link @title, href: @url
  end
end
