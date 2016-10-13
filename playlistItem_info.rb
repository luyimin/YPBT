require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
yt_response = {}
results = {}


type_name = 'playlistItems'

playlistItems_response = HTTP.get("https://www.googleapis.com/youtube/v3/#{type_name}",
                      params: { playlistId: credentials[:playlist_id] ,
                                key: credentials[:API_KEY] ,
                                part: 'id' })

yt_response[:playlistItems] =   playlistItems_response
playlistItems = JSON.load(playlistItems_response.to_s)
results[:playlistItems] = playlistItems

itemsContent_response = HTTP.get("https://www.googleapis.com/youtube/v3/#{type_name}",
                      params: { playlistId: credentials[:playlist_id] ,
                                key: credentials[:API_KEY] ,
                                part: 'snippet' ,
                                fields: 'items(snippet(title,channelId,publishedAt))'})


items = JSON.load(itemsContent_response.to_s)['items']
results[:items] = items




File.write('yt_response.yml', yt_response.to_yaml)
File.write('results.yml', results.to_yaml)
