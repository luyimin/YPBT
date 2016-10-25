# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Video specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') { CREDENTIALS[:api_key] }
    c.filter_sensitive_data('<API_KEY_ESCAPED>') do
      URI.escape(CREDENTIALS[:api_key])
    end
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
    @youtube_api = YoutubeVideo::YtApi.new(
      api_key: CREDENTIALS[:api_key]
    )
  end

  after do
    VCR.eject_cassette
  end

  it 'should be able to open a video' do
    video = YoutubeVideo::Video.find(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    video.title.length.must_be :>, 0
  end

  it 'should get the latest commentThreads from a video' do
    video = YoutubeVideo::Video.find(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )
    commentthreads = video.commentthreads
    commentthreads.count.must_be :>, 10
  end

  it 'should get information about comment on the commentThreads' do
    video = YoutubeVideo::Video.find(
      @youtube_api,
      video_id: CREDENTIALS[:video_id]
    )

    video.commentthreads.each do |comment|
      comment.comment_id.wont_be_nil
      comment.text_display.wont_be_nil
    end
  end

  it 'should find all parts of a full comment' do
    comment = YT_RESULT['comment'].first
    retrieved = YoutubeVideo::Comment.find(
      @youtube_api, comment_id: comment['id']
    )

    retrieved.comment_id.must_equal comment['id']
    retrieved.published_at.must_equal comment['snippet']['publishedAt']
    retrieved.updated_at.must_equal comment['snippet']['updateAt']
    retrieved.text_display.must_equal comment['snippet']['textDisplay']

    retrieved.author.wont_be_nil
    # retrieved.author.author_image_url.must_equal comment['snippet']['authorProfileImageUrl']
    # retrieved.author.author_channel_url.must_equal comment['snippet']['authorChannelUrl']
  end
end
