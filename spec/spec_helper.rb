# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/comment_threads.rb'
require './lib/display_text.rb'
require './lib/youtube_api.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
YT_RESPONSE = YAML.load(File.read('spec/fixtures/yt_response.yml'))
RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
