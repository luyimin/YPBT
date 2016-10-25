# frozen_string_literal: true
require 'yaml'
require 'http'

credentials = YAML.load(File.read('config/credentials.yml'))
yt_response = {}
results = {}

resource_name = 'commentThreads'

field = 'items(snippet(channelId,description,publishedAt,title))'
video_response =
  HTTP.get('https://www.googleapis.com/youtube/v3/videos',
           params: {  id:     credentials[:video_id],
                      key:    credentials[:api_key],
                      part:   'snippet',
                      fields: field })
yt_response[:video] = video_response
video = JSON.parse(video_response.to_s)['items'][0]['snippet']
results[:video] = video

comment_response =
  HTTP.get('https://www.googleapis.com/youtube/v3/comments',
           params: {  id:     'z13ryv5pynjvtfgst23iy5uxhsrkvzzfz',
                      key:    credentials[:api_key],
                      part:   'snippet' })
yt_response[:comment] = comment_response
comment = JSON.parse(comment_response.to_s)['items']
results[:comment] = comment

comment_threads_response =
  HTTP.get("https://www.googleapis.com/youtube/v3/#{resource_name}",
           params: { videoId:  credentials[:video_id],
                     key:      credentials[:api_key],
                     order:    'relevance',
                     part:     'snippet' })
yt_response[:comment_threads] = comment_threads_response
comment_threads = JSON.parse(comment_threads_response.to_s)['items']
results[:comment_threads] = comment_threads

fields = 'items/snippet/topLevelComment/snippet/textDisplay'
text_display_response =
  HTTP.get("https://www.googleapis.com/youtube/v3/#{resource_name}",
           params: { videoId:  credentials[:video_id],
                     key:      credentials[:api_key],
                     order:    'relevance',
                     part:     'snippet',
                     fields:   fields })
text_display = JSON.parse(text_display_response)
results[:text_display] = text_display

File.write('yt_response.yml', yt_response.to_yaml)
File.write('results.yml', results.to_yaml)
