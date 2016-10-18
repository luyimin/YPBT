require_relative 'youtube_api'
require_relative 'comment_threads'

module VideoCommentThreads
  #Main class to setup a LikedVideos
  class DisplayText
  attr_reader :comment

    def initialize(youtube_api, video_id:, api_key:, fields:)
     @youtube_api = youtube_api
     @video_id = video_id
     @api_key = api_key
     @fields = fields
     @comment = @youtube_api.text_display_info(@video_id, @fields)
    end

    def text_display
      return @text_display if @text_display
      text_display = @youtube_api.text_display_info(@video_id, @fields)
      @text_display = text_display
    end

  end
 end
