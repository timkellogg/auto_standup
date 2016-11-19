module Standup
  class ApiClient
    def initialize(username, password)
      @username = username
      @client = Github.new basic_auth: "#{username}:#{password}"
    end

    def commits(repo_owner, repo_name, time_span)
      @client.repos.commits.list(repo_owner, repo_name, Time.now - time_span)
    end

    def filter_by_name(results, name = @username)
      results.select { |result| result.commit.author.name == name }
    end

    def commmit_messages(results)
      results.map { | result | result.commit.message }
    end
  end
end
