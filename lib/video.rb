# frozen_string_literal: true
require_relative 'comment'
require_relative 'youtube_api'

module YoutubeVideo
  # Main class to setup a Video
  class Video
    attr_reader :title

    def initialize(youtube_api, data:)
      @youtube_api = youtube_api
      @title = data['snippet']['title']
      @id = data['id']
    end

    def commentthreads
      return @commentthreads if @commentthreads
      raw_threads = @youtube_api.video_commentthreads_info(@id)
      @commentthreads = raw_threads.map do |comment|
        YoutubeVideo::Comment.new(
          @youtube_api, data: comment['snippet']['topLevelComment']
        )
      end
    end

    def self.find(youtube_api, video_id:)
      video_data = youtube_api.video_info(video_id)
      new(youtube_api, data: video_data)
    end
  end
end
