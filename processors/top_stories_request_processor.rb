# frozen_string_literal: true

require('./models/top_stories')
require('./models/story')
require('./models/formatted_story')

# Request processor for hackernews top stories with details
class TopStoriesRequestProcessor
  def execute
    ids = TopStories.new.fetch
    ids.map! do |id|
      story = Story.new(id).info
      FormattedStory.new(story).format
    end
  end
end
