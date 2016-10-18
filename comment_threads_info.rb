require 'yaml'
require 'http'

credentials = YAML.load(File.read('config/credentials.yml'))
yt_response = {}
results = {}

resource_name = 'commentThreads'

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
