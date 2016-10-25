# frozen_string_literal: true
require 'http'
require 'json'

module YoutubeVideo
  # Service for all Youtube API calls
  class YtApi
    YT_URL = 'https://www.googleapis.com'
    YT_COMPANY = 'youtube'
    YT_COMPANY_URL = URI.join(YT_URL, "#{YT_COMPANY}/")
    API_VER = 'v3'
    YT_RESOURCE = 'commentThreads'
    YT_API_URL = URI.join(YT_COMPANY_URL, "#{API_VER}/")
    YT_RESOURCE_URL = URI.join(YT_API_URL, YT_RESOURCE.to_s)

    def initialize(api_key:)
      @api_key = api_key
    end

    def yt_resource_url(resouce_name)
      URI.join(YT_API_URL, resouce_name.to_s)
    end

    def video_info(video_id)
      field = 'items(snippet(channelId,description,publishedAt,title))'
      video_response = HTTP.get(yt_resource_url('videos'),
                                params: { id:     video_id,
                                          key:    @api_key,
                                          part:   'snippet',
                                          fields: field })
      JSON.parse(video_response.to_s)['items'][0]['snippet']
    end

    def video_commentthreads_info(video_id)
      comment_threads_response = HTTP.get(yt_resource_url('commentThreads'),
                                          params: { videoId:  video_id,
                                                    key:      @api_key,
                                                    order:    'relevance',
                                                    part:     'snippet' })
      JSON.parse(comment_threads_response.to_s)['items']
    end

    def comment_authors_info(comment_id)
      comment_authors_response = HTTP.get(yt_resource_url('comments'),
                                          params: { id: comment_id,
                                                    key: @api_key,
                                                    part: 'snippet' })
      JSON.parse(comment_authors_response.to_s)['items']
    end
    # def text_display_info(video_id, fields)
    #   text_display_response = HTTP.get(YT_RESOURCE_URL,
    #                                    params: {  videoId: video_id,
    #                                               key:     @api_key,
    #                                               order:  'relevance',
    #                                               part:   'snippet',
    #                                               fields: fields })
    #   JSON.parse(text_display_response.to_s)['items']
    # end
  end
end
