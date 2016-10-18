require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/comment_threads.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
YT_RESPONSE = YAML.load(File.read('spec/fixtures/yt_response.yml'))
RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))

describe 'VideoCommentThreads specifications' do
  before do
    @youtube_api = VideoCommentThreads::YtApi.new(
      api_key: CREDENTIALS[:api_key]
    )
  end

  it 'should be able to create a comment threads of a video' do
    comment_threads = VideoCommentThreads::CommentThreads.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id],
      api_key:  CREDENTIALS[:api_key]
    )
    comment_threads.kind.length.must_be :>, 0
  end

  it 'should get comment threads information about the video' do
    comment_threads = VideoCommentThreads::CommentThreads.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id],
      api_key:  CREDENTIALS[:api_key]
    )
    comment_threads_info = comment_threads.comment_threads
    comment_threads_info.size.must_be :>, 10
  end
end
