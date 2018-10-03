# frozen_string_literal: true

# Display information about a specific story
class Story < Application
  attr_reader :url, :rank

  def initialize(id, rank)
    @url = URI.parse("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    @rank = rank
  end

  def info
    story = execute_again { JSON.parse(Faraday.get(url).body) }
    add_rank(story)
  end

  private

  def add_rank(story)
    story.merge('rank' => rank)
  end
end
