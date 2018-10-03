# frozen_string_literal: true

# Request processor for hackernews top stories with details
class TopStoriesRequestProcessor
  def execute
    stories = []
    ids = TopStories.new.fetch[0...ARGV[1].to_i]

    ids.each_with_index do |id, rank|
      story = Story.new(id, rank).info
      stories << FormattedStory.new(story).format
    end

    puts(ResponseValidation.new(stories).validate_stories.to_json)
  end
end
