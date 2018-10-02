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
    remove_details
    sort_by_key
  end

  private

  def map_keys
    MAPPING.each { |k, v| story[v] = story.delete(k) }
  end

  def remove_details
    story.keep_if { |k| KEYS.include?(k) }
  end

  def sort_by_key
    story.to_a.sort_by { |hash| KEYS.index(hash[0]) }.to_h
  end
end
