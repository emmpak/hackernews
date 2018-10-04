# frozen_string_literal: true

# Validates the formatted story.
class ResponseValidation
  attr_reader :story

  def initialize(story)
    @story = story
  end

  def invalid?
    restricted_value?(story.values)   ||
      invalid_uri?(story['url'])      ||
      invalid_number?(story.values)
  end

  private

  def invalid_number?(values)
    values.any? { |value| value.negative? if value.is_a?(Numeric) }
  end

  def restricted_value?(values)
    values.any? { |value| value.nil? || value == '' }
  end

  def invalid_uri?(uri)
    uri_regexp = %r/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    !uri_regexp.match?(uri)
  end
end
