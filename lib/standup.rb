require_relative 'api_client'
require_relative 'recorder'

module Standup
  TIME_SPAN_DEFAULT = 60 * 60 * 24

  class App
    def initialize(username, password, filename, repo, company, time_span = TIME_SPAN_DEFAULT)
      @time_span = time_span
      @filename = filename
      @company = company
      @repo = repo

      @api_client = ApiClient.new(username, password)

      build_standup
    end

    def build_standup
      results = @api_client.commits(@company, @repo, @time_span)
      filtered = @api_client.filter_by_name(results, 'Tim Kellogg')
      messages = @api_client.commmit_messages(filtered)
      Recorder.new(@filename, messages)
    end
  end
end

print 'Github username > '
username = gets.chomp

print 'Github password > '
password = gets.chomp

print 'Filepath of output > '
filename = gets.chomp

print 'Repo doing standup for > '
repo = gets.chomp

print 'Organization that owns repo > '
company = gets.chomp

Standup::App.new(username, password, filename, repo, company)