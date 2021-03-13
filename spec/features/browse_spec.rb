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

  scenario "All animons - Picture and link" do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    and_the_animon_has_a_picture
    when_a_user_visits_the_browse_page
    then_the_picture_is_displayed
    and_there_is_a_link_to_all_animons
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

  scenario "Top ranks" do
    given_animons_with_picture_in_5_top_ranks
    when_a_user_visits_the_browse_page
    there_is_a_section_for_each_top_rank
    and_each_section_contains_only_animons_in_this_top_rank
  end

  scenario "Top ranks - Click" do
    given_animons_with_picture_in_5_top_ranks
    when_a_user_visits_the_browse_page
    and_clicks_on_a_phylum
    then_all_animons_in_this_phylum_are_listed
    and_the_title_is_the_phylum
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

  def and_there_is_a_link_to_all_animons
    expect(page).to have_link("📖 All animons", href: animons_path)
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
    expect(page).to have_link("📖 Latest animons", href: animons_path(list: "latest"))
    expected_names = Animon.last(5).reverse.map{|a| a.taxon.common_name}
    latest_names_on_page = link_texts_in_div('animon_latest')
    expect(latest_names_on_page).to eq(expected_names)
  end

  def given_animons_with_picture_in_5_top_ranks
    @phyla = {}
    5.times {
      phylum = create(:phylum)
      @phyla[phylum] = []
      10.times {
        species = create(:species, parent: phylum)
        animon = create(:animon, taxon: species)
        animon.picture.attach(io: File.open(Rails.root.join 'app/assets/images/animon.png'), filename:'animon.png')
        @phyla[phylum] << animon
      }
    }
  end

  def there_is_a_section_for_each_top_rank
    @phyla.keys.each do |p|
      expect(page).to have_link("#{p.common_name.capitalize}s", href: animons_path(taxon: p))
    end
  end

  def and_each_section_contains_only_animons_in_this_top_rank
    animon_ids = []
    @phyla.each do |p,animons|
      within('div', class: "phylum_#{p.id}") do
        animon_ids = extract_animon_ids
      end
      animon_ids.each do |animon_id|
        animon = Animon.find(animon_id)
        expect(animons).to include(animon)
      end
    end
  end

  def and_clicks_on_a_phylum
    phylum, animons = @phyla.first
    click_on "📖 #{phylum.common_name.capitalize}s"
  end

  def then_all_animons_in_this_phylum_are_listed
    expect(page.current_path).to eq(animons_path)
    animon_ids = nil
    within('div', class: 'animon_list') do
      animon_ids = extract_animon_ids
    end
    phylum, animons = @phyla.first
    expected_ids = animons.map{|a| a.id}
    expect(animon_ids).to eq(expected_ids)
  end

  def and_the_title_is_the_phylum
    phylum, animons = @phyla.first
    expect(page).to have_css('.animon-title', text: "#{phylum.common_name.capitalize}s")
  end
end
