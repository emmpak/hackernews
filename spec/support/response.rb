# frozen_string_literal: true

# Examples of HackerNews API responses
module Fixtures
  class HackerNewsResponse
    class << self
      def top_stories
        [9_129_911, 9_129_199, 9_127_761, 9_128_141].to_json
      end
    end
  end
end
