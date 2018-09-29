# frozen_string_literal: true

# Get the top stories from HackerNews
class TopStories
  attr_reader :uri, :stories

  def initialize
    @uri = URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json')
  end

  def fetch
    @stories = JSON.parse(Faraday.get(uri).body)
  end
end
