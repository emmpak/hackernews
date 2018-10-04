# frozen_string_literal: true

# Request processor for hackernews top stories with details
class TopStoriesRequestProcessor
  def execute
    flag = ARGV[0]
    posts = ARGV[1]

    begin
      InputValidation.new(flag, posts).validate

      stories = []
      ids = TopStories.new.fetch

      while stories.length < posts.to_i
        rank = stories.length
        id = ids.shift
        story = Story.new(id, rank).info
        formatted = FormattedStory.new(story).format
        stories << formatted unless ResponseValidation.new(story).invalid?
      end

      puts(stories.to_json)
    rescue InputError
      puts('Invalid input(s). Currently we only support the `--posts` flag and a positive number below 200.')
    rescue StandardError
      puts('Something went wrong. Please try again.')
    end
  end
end
