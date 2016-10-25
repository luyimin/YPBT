# frozen_string_literal: true
require_relative 'comment'
require_relative 'youtube_api'

module YoutubeVideo
  # Main class to setup a VideoCommentThreads
  class Comment
    attr_reader :title, :comment_id, :text_display, :updated_at

    def initialize(youtube_api, comment_id:, text_display:, updated_at:)
      @youtube_api = youtube_api
      @text_display = text_display
      @comment_id = comment_id
      @updated_at = updated_at
    end

    def author
      return @author if @author
      author_data = @youtube_api.comment_authors_info(@comment_id)
      @author = {
        authorName:       author_data.first['snippet']['authorDisplayName'],
        authorImageUrl:   author_data.first['snippet']['authorProfileImageUrl'],
        authorChannelUrl: author_data.first['snippet']['authorChannelUrl']
      }
    end

    # def self.find(youtube_api, video_id:)
    #   comment_threads_data = youtube_api.comment_threads_info(video_id)
    #   new(youtube_api, data: comment_threads_data)
    # end
  end
end
