# frozen_string_literal: true

# Validates the formatted story; If invalid, it is removed from the output.
class ResponseValidation
  attr_reader :stories

  def initialize(stories)
    @stories = stories
  end

  def validate_stories
    stories.map do |story|
      next if restricted_value?(story.values) ||
              invalid_uri?(story['uri'])      ||
              invalid_number?(story.values)

      update(story)
    end.compact
  end

  private

  def update(story)
    update_value_length(story, 'author') if invalid_length?(story, 'author')
    update_value_length(story, 'title') if invalid_length?(story, 'title')
    story
  end

  def invalid_number?(values)
    values.any? { |value| value.negative? if value.is_a?(Numeric) }
  end

  def update_value_length(story, key)
    story[key] = story[key][0..252] + '...'
  end

  def invalid_length?(story, key)
    story[key].length > 256
  end

  def restricted_value?(values)
    values.any? { |value| value.nil? || value == '' }
  end

  def invalid_uri?(uri)
    uri_regexp = %r/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    !uri_regexp.match?(uri)
  end
end
