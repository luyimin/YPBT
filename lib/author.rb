# frozen_string_literal: tru
module YoutubeVideo
  # comment's author infomation
  class Author
    attr_reader :author_name, :author_image_url, :author_channel_url
    def initialize(data)
      return unless data
      @author_name = data[0]['snippet']['authorDisplayName']
      @author_image_url = data[0]['snippet']['authorProfileImageUrl']
      @author_channel_url = data[0]['snippet']['authorChannelUrl']
    end
  end
end
