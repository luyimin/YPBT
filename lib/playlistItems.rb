require_relative 'yt_api'


module LikedVideos
  #Main class to setup a LikedVideos
  class PlaylistItems
  attr_reader :id

    def initialize(yt_api,playlist_id:, API_KEY: )
      @yt_api = yt_api
      playlistItems = @yt_api.playlistItems_info(playlist_id, API_KEY )
      @id = playlistItems['items'][0]['id']
    end

    def itemsContent(playlist_id:, API_KEY: )
     return @itemsContent if @itemsContent
     content = @yt_api.playlistItems_itemsContent(playlist_id, API_KEY)
     @itemsContent = itemsContent.map do |p|
     LikevVideos::PlaylistItems.new(
     p['items'][0]['publishedAt'],   p['items'][0]['channelId'] , p['items'][0]['title']
     )
      end
    end
  end
 end
