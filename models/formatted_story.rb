# frozen_string_literal: true

# Formats story info
class FormattedStory
  KEYS = %w[title uri author points comments rank].freeze
  MAPPING = {
    'by' => 'author',
    'url' => 'uri',
    'score' => 'points',
    'descendants' => 'comments'
  }.freeze

  attr_reader :story

  def initialize(story)
    @story = story
  end

  def format
    map_keys
    update
    remove_details
    sort_by_key
  end

  private

  def map_keys
    MAPPING.each { |k, v| story[v] = story.delete(k) }
  end

  def update
    update_value_length(story, 'author') if invalid_length?(story, 'author')
    update_value_length(story, 'title') if invalid_length?(story, 'title')
  end

  def update_value_length(story, key)
    story[key] = story[key][0..252] + '...'
  end

  def invalid_length?(story, key)
    story[key].length > 256
  end

  def remove_details
    story.keep_if { |k| KEYS.include?(k) }
  end

  def sort_by_key
    story.to_a.sort_by { |hash| KEYS.index(hash[0]) }.to_h
  end
end
