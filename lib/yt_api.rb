require 'http'
require 'json'

module LikedVideos

  class YtApi
    YT_URL = 'https://www.googleapis.com/youtube'
    API_VER = 'v3'
    YT_RESOURCE ='playlistItems'
    YT_API_URL = URI.join(YT_URL, "#{API_VER}/")
    YT_RESOURCE_URL = URI.join(YT_API_URL, "#{YT_RESOURCE}")


    def playlistItems_info(playlist_id, API_KEY)

      playlistItems_response = HTTP.get(YT_RESOURCE_URL ,
                            params: { playlistId: playlist_id ,
                                      key: API_KEY ,
                                      part: 'id' })

           JSON.load(playlistItems_response.to_s)
    end

    def playlistItems_itemsContent(playlist_id, API_KEY)
      title_response = HTTP.get(YT_RESOURCE_URL ,
                            params: { playlistId: playlist_id ,
                                      key: API_KEY ,
                                      part: 'snippet' ,
                                      fields: 'items(snippet(title,channelId,publishedAt))'})
      itemsContent = JSON.load(itemsContent_response.to_s)['items']
    end


  end
end
