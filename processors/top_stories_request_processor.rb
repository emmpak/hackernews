# frozen_string_literal: true

# Request processor for hackernews top stories with details
class TopStoriesRequestProcessor
  def execute
    flag = ARGV[0]
    posts = ARGV[1]

    begin
      InputValidation.new(flag, posts).validate

      stories = []
      ids = TopStories.new.fetch[0...posts.to_i]

      ids.each_with_index do |id, rank|
        story = Story.new(id, rank).info
        stories << FormattedStory.new(story).format
      end

      puts(ResponseValidation.new(stories).validate_stories.to_json)
    rescue InputError
      puts('Invalid input(s). Currently we only support the `--posts` flag and a positive number below 200.')
    end
  end
end
