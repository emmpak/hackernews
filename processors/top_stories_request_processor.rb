# frozen_string_literal: true

# Request processor for hackernews top stories with details
class TopStoriesRequestProcessor
  attr_reader :format_class, :validation_class

  def initialize(format_class, validation_class)
    @format_class = format_class
    @validation_class = validation_class
  end

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
        stories << format_class.new(story).format unless validation_class.new(story).invalid?
      end

      p(stories)
    rescue InputError
      puts('Invalid input(s). Currently we only support the `--posts` flag and a positive number below 200.')
    rescue StandardError
      puts('Something went wrong. Please try again.')
    end
  end
end
