# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'VideoCommentThreads specifications' do
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

    @youtube_api = VideoCommentThreads::YtApi.new(
      api_key: CREDENTIALS[:api_key]
    )
  end

  after do
    VCR.eject_cassette
  end

  it 'should be able to create the display text of a video' do
    textdisplay = VideoCommentThreads::DisplayText.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id],
      api_key:  CREDENTIALS[:api_key],
      fields:   CREDENTIALS[:fields]
    )

    textdisplay.comment.length.must_be :>, 0
  end

  it 'should get display text information about the video' do
    textdisplay = VideoCommentThreads::DisplayText.new(
      @youtube_api,
      video_id: CREDENTIALS[:video_id],
      api_key:  CREDENTIALS[:api_key],
      fields:   CREDENTIALS[:fields]
    )
    text_display_info = textdisplay.text_display
    text_display_info.size.must_be :>, 10
  end
end
