class HomeController < ApplicationController
  def index
    sample = 5
    total = 10

    @latest_contents = []
    @latest_contents.concat Taxon.latest_created(sample)
    @latest_contents.concat YoutubeVideo.latest_created(sample)
    @latest_contents = @latest_contents.sort_by(&:created_at).reverse
    @latest_contents = @latest_contents[0, total]

    @latest_content_strings = []
    @latest_contents.each{ |content|
      @latest_content_strings << string_for_content(content)
    }
  end

  private

  def string_for_content(content_object)
    content_string = ''.html_safe
    case content_object
    when Taxon
      content_string << "New #{content_object.rank}: "
      content_string << helpers.link_to(content_object.common_name, helpers.taxon_path(content_object))
    when YoutubeVideo
      content_string << "New video added to "
      content_string << helpers.link_to(content_object.taxon.common_name, helpers.taxon_path(content_object.taxon))
    end
    content_string
  end

end
