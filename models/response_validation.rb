# frozen_string_literal: true

class ResponseValidation
  attr_reader :stories

  def initialize(stories)
    @stories = stories
  end

  def validate_stories
    stories.map do |story|
      if restricted_value?(story.values) || invalid_uri?(story['uri'])
        nil
      else
        validate_and_update(story)
      end
    end.compact
  end

  private

  def validate_and_update(story)
    update_value_length(story, 'author') if invalid_length?(story, 'author')
    update_value_length(story, 'title') if invalid_length?(story, 'title')
    story
    # validate_numbers(['points', 'comments', 'rank'])
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
