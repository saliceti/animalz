require "rails_helper"


feature 'Animon Points' do
  scenario 'New animon' do
    given_a_new_animon
    when_it_is_displayed
    then_points_is_default_value
  end
  scenario 'Add animon link increase' do
    given_a_new_animon
    when_a_new_animon_link_is_added
    then_points_counter_is_increased
  end
  scenario 'Add video increase' do
    given_a_new_animon
    when_a_new_video_is_added
    then_points_counter_is_increased
  end
  scenario 'Add getty image increase' do
    given_a_new_animon
    when_a_new_getty_image_is_added
    then_points_counter_is_increased
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

  def when_a_new_video_is_added
    expect{create(:youtube_video, animon: @animon)}.to change{@animon.points}.by 10
  end

  def then_points_counter_is_increased
    visit(animon_path(@animon))
    expect(page).to have_text("Points: 10")
  end

  def when_a_new_getty_image_is_added
    expect{create(:getty_image, animon: @animon)}.to change{@animon.points}.by 10
  end

  def when_a_new_animon_link_is_added
    expect{create(:animon_link, animon: @animon)}.to change{@animon.points}.by 10
  end
end
