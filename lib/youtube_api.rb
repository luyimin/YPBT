# frozen_string_literal: true
require 'http'
require 'json'

module VideoCommentThreads
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

    def comment_threads_info(video_id)
      comment_threads_response = HTTP.get(YT_RESOURCE_URL,
                                          params: { videoId:  video_id,
                                                    key:      @api_key,
                                                    order:    'relevance',
                                                    part:     'snippet' })
      JSON.parse(comment_threads_response.to_s)['items']
    end

    def text_display_info(video_id, fields)
      text_display_response = HTTP.get(YT_RESOURCE_URL,
                                       params: {  videoId: video_id,
                                                  key:     @api_key,
                                                  order:  'relevance',
                                                  part:   'snippet',
                                                  fields: fields })
      JSON.parse(text_display_response.to_s)['items']
    end
  end
end
