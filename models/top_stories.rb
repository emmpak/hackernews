# frozen_string_literal: true

require_relative('application')

# Get the top stories from HackerNews
class TopStories < Application
  attr_reader :url, :stories

  def initialize
    @url = URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json')
  end

  def fetch
    @stories = execute_again { JSON.parse(Faraday.get(url).body) }
  end
end
