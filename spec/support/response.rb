# frozen_string_literal: true

# Examples of HackerNews API responses
module Fixtures
  class HackerNewsResponse
    class << self
      def top_stories
        [9_129_911, 9_129_199, 9_127_761, 9_128_141].to_json
      end

      def story
        {
          "by" => "dhouston",
          "descendants" => 71,
          "id" => 8863,
          "kids" => [8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005],
          "score" => 111,
          "time" => 1175714200,
          "title" => "My YC app: Dropbox - Throw away your USB drive",
          "type" => "story",
          "url" => "http://www.getdropbox.com/u/2/screencast.html"
        }.to_json
      end
    end
  end
end
