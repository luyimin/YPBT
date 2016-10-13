require 'http'
require_relative 'items'

module LikedVideos
  #Main class to setup a LikedVideos
  class playlistItems
  attr_reader :id

    def initialize(playlist_id, API_KEY )

      playlistItems_response = HTTP.get("https://www.googleapis.com/youtube/v3/playlistItems",
                            params: { playlistId: playlist_id ,
                                      key: API_KEY ,
                                      part: 'id' })

     playlistItems = JSON.load(playlistItems_response.to_s)
     @id = playlistItems['items'][0]['id']

    end

    def itemsContent
     return @itemsContent if @itemsContent

     itemsContent_response = HTTP.get("https://www.googleapis.com/youtube/v3/playlistItems",
                           params: { playlistId: credentials[:playlist_id] ,
                                     key: credentials[:API_KEY] ,
                                     part: 'snippet' ,
                                     fields: 'items(snippet(title,channelId,publishedAt))'})
     itemsContent = JSON.load(itemsContent_response.to_s)['items']
     results[:items] = items
     @itemsContent = itemsContent.map do |p|
     LikevVideos::Posting.new(
     p['items'][0]['publishedAt'],   p['items'][0]['channelId'] , p['items'][0]['title']
     )

      end
    end
  end
 end
