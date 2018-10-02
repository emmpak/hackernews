# frozen_string_literal: true

require 'uri'

class ResponseValidation
  UNKNOWN = 'Unknown details'
  INVALID_URI = 'Invalid URI'

  attr_reader :story

  def initialize(story)
    @story = story
  end

  def validate_and_update
    validate_values
    # validate_length(['author', 'title'])
    validate_uri
    # validate_numbers(['points', 'comments', 'rank'])
  end

  private

  def validate_values
    story.each { |k, v| story[k] = UNKNOWN if restricted_value?(v) }
  end

  def validate_length
  end

  def validate_uri
    story['uri'] = INVALID_URI unless valid_uri?(story['uri'])
  end

  def restricted_value?(detail)
    detail.nil? || detail == ''
  end

  def valid_uri?(uri)
    uri_regexp = %r(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/)ix
    uri_regexp.match?(uri)
  end
end
