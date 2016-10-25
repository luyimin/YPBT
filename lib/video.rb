# frozen_string_literal: true
require_relative 'comment'
require_relative 'youtube_api'

module YoutubeVideo
  # Main class to setup a Video
  class Video
    attr_reader :title

    def initialize(data:)
      @title = data['snippet']['title']
      @id = data['id']
    end

    def commentthreads
      return @commentthreads if @commentthreads
      raw_threads = YoutubeVideo::YtApi.video_commentthreads_info(@id)
      @commentthreads = raw_threads.map do |comment|
        YoutubeVideo::Comment.new(
          data: comment['snippet']['topLevelComment']
        )
      end
    end

    def self.find(video_id:)
      video_data = YoutubeVideo::YtApi.video_info(video_id)
      new(data: video_data)
    end
  end
end
