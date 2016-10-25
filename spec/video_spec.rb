# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/video.rb'
require './lib/comment.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
# YT_RESPONSE = YAML.load(File.read('spec/fixtures/yt_response.yml'))
# RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))

describe 'Video specifications' do
  before do
    @youtube_api = YoutubeVideo::YtApi.new(
      api_key: CREDENTIALS[:api_key]
    )
  end

  it 'should be able to open a video' do
    video = YoutubeVideo::Video.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    video.title.length.must_be :>, 0
  end

  it 'should get the latest commentThreads from a video' do
    video = YoutubeVideo::Video.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    commentthreads = video.commentthreads
    commentthreads.count.must_be :>, 10
  end

  it 'should get information about comment on the commentThreads' do
    video = YoutubeVideo::Video.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    comment = video.commentthreads.first
    comment.text_display.length.must_be :>, 0
  end

  it 'should find author information in comment' do
    video = YoutubeVideo::Video.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    comment = video.commentthreads.first
    comment.author[:authorName].length.must_be :>, 0
  end
end
