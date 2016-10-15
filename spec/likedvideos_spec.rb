# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/playlistItem.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
YT_RESPONSE = YAML.load(File.read('yt_response.yml'))
RESULTS = YAML.load(File.read('results.yml'))

describe 'LikedVideos specifications' do
  it 'should be able to create a play list of liked videos' do
    play_list = LikedVideos::playlistItems.new(
      playlist_id: CREDENTIALS[:playlist_id]
      API_KEY: CREDENTIALS[:API_KEY]
    )

    play_list.playlistitems.length.must_be :>, 0
  end

  it 'should get information about the publication date' do
    play_list = LikedVideos::playlistItems.new(
      playlist_id: CREDENTIALS[:playlist_id]
      API_KEY: CREDENTIALS[:API_KEY]
    )

    video = play_list.itemsContent.first
    video[:publishedAt].length.must_be :>, 0
  end

  it 'should get information about the identification of the channel' do
    play_list = LikedVideos::playlistItems.new(
      playlist_id: CREDENTIALS[:playlist_id]
      API_KEY: CREDENTIALS[:API_KEY]
    )

    video = play_list.itemsContent.first
    video[:channelId].length.must_be :>, 0
  end

  it 'should get information about the video title' do
    play_list = LikedVideos::playlistItems.new(
      playlist_id: CREDENTIALS[:playlist_id]
      API_KEY: CREDENTIALS[:API_KEY]
    )

    video = play_list.itemsContent.first
    video[:title].length.must_be :>, 0
  end
end
