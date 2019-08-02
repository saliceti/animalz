ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_form_contains_list_of model_class
    list_for_options = model_class.all.map{|p| p.name}
    assert_select 'option' do |options|
      options.each do |option|
        assert list_for_options.include?(option.child.to_s)
      end
    end
  end
end
