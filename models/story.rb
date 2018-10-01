# frozen_string_literal: true

# Display information about a specific story
class Story < Application
  attr_reader :url

  def initialize(id)
    @url = URI.parse("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
  end

  def info
    execute_again { JSON.parse(Faraday.get(url).body) }
  end
end
