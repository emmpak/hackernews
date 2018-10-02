# frozen_string_literal: true

class ResponseValidation
  UNKNOWN = 'Unknown details'
  INVALID_URI = 'Invalid URI'

  attr_reader :story

  def initialize(story)
    @story = story
  end

  def validate_and_update
    update_restricted_values if restricted_value?(story.values)
    update_value_length(%w[author title]) if invalid_length?(%w[author title])
    update_uri unless valid_uri?(story['uri'])
    # validate_numbers(['points', 'comments', 'rank'])
  end

  private

  def update_restricted_values
    story.each { |key, value| story[key] = UNKNOWN if restricted_value?([value]) }
  end

  def update_value_length(keys)
    keys.each { |key| story[key] = story[key][0..252] + '...' }
  end

  def update_uri
    story['uri'] = INVALID_URI
  end

  def invalid_length?(keys)
    keys.any? { |key| story[key].length > 256 }
  end

  def restricted_value?(values)
    values.any? { |value| value.nil? || value == '' }
  end

  def valid_uri?(uri)
    uri_regexp = %r(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/)ix
    uri_regexp.match?(uri)
  end
end
