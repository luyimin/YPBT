# frozen_string_literal: true
require_relative 'comment'
require_relative 'youtube_api'

module YoutubeVideo
  # Main class to setup a VideoCommentThreads
  class Video
    attr_reader :title

    def initialize(youtube_api, video_id:)
      @youtube_api = youtube_api
      video = @youtube_api.video_info(video_id)
      @title = video['title']
      @id = video_id
      # @video_id = video_id
      # @kind = @youtube_api.comment_threads_info(@video_id)[0]['kind']
    end

    def commentthreads
      return @commentthreads if @commentthreads
      raw_threads = @youtube_api.video_commentthreads_info(@id)
      @commentthreads = raw_threads.map do |p|
        YoutubeVideo::Comment.new(
          @youtube_api,
          comment_id: p['id'],
          text_display: p['snippet']['topLevelComment']['snippet']['textDisplay'],
          updated_at: p['snippet']['topLevelComment']['snippet']['updateAt']
        )
      end
    end
    # def comment_threads
    #   return @comment_threads_items if @comment_threads_items
    #   @comment_threads = @youtube_api.comment_threads_info(@video_id)
    # end

    # def self.find(youtube_api, video_id:)
    #   comment_threads_data = youtube_api.comment_threads_info(video_id)
    #   new(youtube_api, data: comment_threads_data)
    # end
  end
end
