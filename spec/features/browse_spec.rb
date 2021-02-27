require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'Browse' do
  scenario 'Visit' do
    when_a_user_visits_the_browse_page
    then_the_browse_title_is_displayed
  end

  scenario "All animons" do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_visits_the_browse_page
    and_the_user_clicks_on_all_animons
    then_the_animon_is_listed
  end

  scenario "All animons - Picture and link" do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    and_the_animon_has_a_picture
    when_a_user_visits_the_browse_page
    then_the_picture_is_displayed
  end

  scenario "All animons - Random" do
    given_many_animons_with_picture
    when_a_user_visits_the_browse_page_twice
    then_the_order_is_different
  end

  scenario "Latest animons" do
    given_many_animons_with_picture
    when_a_user_visits_the_browse_page
    then_only_the_latest_animons_are_displayed
  end

  scenario "Latest animons - Click" do
    given_many_animons_with_picture
    when_a_user_visits_the_browse_page
    and_clicks_latest_animons
    then_animons_are_listed_in_reverse_chronological_order
    and_the_title_is_latest_animons
  end

  def when_a_user_visits_the_browse_page
    visit browse_index_path
  end

  def then_the_browse_title_is_displayed
    expect(page).to have_text('Browse all Animons')
  end


  def and_an_animon_is_linked_to_a_taxon
    species = Taxon.where(rank: 'Species').first
    @animon = Animon.new(taxon: species)
    @animon.save
  end

  def and_the_user_clicks_on_all_animons
    click_on 'All animons'
  end

  def then_the_animon_is_listed
    expect(page).to have_link @animon.taxon.common_name, href: animon_path(@animon)
    expect(page).to have_link "#{@animon.taxon.rank}: #{@animon.taxon.scientific_name}", href: taxon_path(@animon.taxon)
  end

  def and_the_animon_has_a_picture
    @animon = Animon.first
    @animon.picture.attach(io: File.open(Rails.root.join 'app/assets/images/animon.png'), filename:'animon.png')
  end

  def then_the_picture_is_displayed
    within('div', class: 'animon_all') do
      expect(page).to have_css("img[src*='animon.png']")
      expect(page).to have_link(href: animon_path(@animon))
    end
  end

  def given_many_animons_with_picture
    genus = create(:genus)
    10.times {
      species = create(:species)
      animon = create(:animon, taxon: species)
      animon.picture.attach(io: File.open(Rails.root.join 'app/assets/images/animon.png'), filename:'animon.png')
    }
  end

  def link_texts_in_div(div)
    within('div', class: div) do
      return page.all(:css, 'a').filter_map{|a| a.text unless a.text.blank?}
    end
  end

  def when_a_user_visits_the_browse_page_twice
    visit browse_index_path
    @links_0 = link_texts_in_div('animon_all')

    visit browse_index_path
    @links_1 = link_texts_in_div('animon_all')
  end

  def then_the_order_is_different
    expect(@links_0).not_to eq(@links_1)
  end

  def then_only_the_latest_animons_are_displayed
    expected_names = Animon.last(5).reverse.map{|a| a.taxon.common_name}
    latest_names_on_page = link_texts_in_div('animon_latest')
    expect(latest_names_on_page).to eq(expected_names)
  end

  def and_clicks_latest_animons
    click_on 'Latest animons'
  end

  def then_animons_are_listed_in_reverse_chronological_order
    expect(page.current_path).to eq(animons_path)
    animon_ids = nil
    within('div', class: 'animon_list') do
      animon_ids = page.all(:css, 'a')
        .filter_map{|a|
          if a[:href].starts_with? animons_path
            a[:href].delete_prefix("#{animons_path}/").to_i
          end
        }
    end
    expected_ids = Animon.all.reverse.map{|a| a.id}
    expect(animon_ids).to eq(expected_ids)
  end

  def and_the_title_is_latest_animons
    expect(page).to have_css('.animon-title', text: 'Latest animons')
  end
end
