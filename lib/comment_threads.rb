# frozen_string_literal: true
require_relative 'display_text'
require_relative 'youtube_api'

module VideoCommentThreads
  # Main class to setup a VideoCommentThreads
  class CommentThreads
    attr_reader :data

    def initialize(youtube_api, data:)
      @youtube_api = youtube_api
      @data = data
      # @video_id = video_id
      # @kind = @youtube_api.comment_threads_info(@video_id)[0]['kind']
    end

    # def comment_threads
    #   return @comment_threads_items if @comment_threads_items
    #   @comment_threads = @youtube_api.comment_threads_info(@video_id)
    # end

    def self.find(youtube_api, video_id:)
      comment_threads_data = youtube_api.comment_threads_info(video_id)
      new(youtube_api, data: comment_threads_data)
    end
  end
end
