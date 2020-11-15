class HomeController < ApplicationController
  helper_method :strings_for_content

  def index
    sample = 5
    total = 10

    @latest_contents = []
    @latest_contents.concat Taxon.latest_created(sample)
    @latest_contents.concat YoutubeVideo.latest_created(sample)
    @latest_contents = @latest_contents.sort_by(&:created_at).reverse
    @latest_contents = @latest_contents[0, total]
  end

  private

  def strings_for_content(content_object)
    content_strings = {}
    content_strings['text'] = ''.html_safe
    case content_object
    when Taxon
      content_strings['text'] << "New #{content_object.rank}: "
      content_strings['text'] << helpers.link_to(content_object.common_name, helpers.taxon_path(content_object))
    when YoutubeVideo
      content_strings['text'] << "New video added to "
      content_strings['text'] << helpers.link_to(content_object.taxon.common_name, helpers.taxon_path(content_object.taxon))
      # content_strings['visual'] = helpers.image_tag(youtube_thumbnail_link(content_object.youtube_id), class: 'thumbnail')
      thumbnail = helpers.image_tag(youtube_thumbnail_link(content_object.youtube_id), class: 'thumbnail')
      content_strings['visual'] = helpers.link_to thumbnail, helpers.taxon_path(content_object.taxon)
    end
    content_strings
  end

  def youtube_thumbnail_link(video)
    "https://img.youtube.com/vi/#{video}/0.jpg"
  end

end
