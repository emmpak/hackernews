# frozen_string_literal: true

require_relative('./response')

# Examples of HackerNews API responses
module Fixtures
  class StoryExample
    class << self
      def formatted_story
        {
          'title' => 'My YC app: Dropbox - Throw away your USB drive',
          'uri' => 'http://www.getdropbox.com/u/2/screencast.html',
          'author' => 'dhouston',
          'points' => 111,
          'comments' => 71,
          'rank' => 2
        }.to_json
      end

      def story
        JSON.parse(HackerNewsResponse.story).merge('rank' => 2)
      end

      def output_message
        [formatted_story * 2]
      end

      def invalid
        [title, uri, author, comments]
      end

      def valid
        [story, points, length]
      end

      def title
        story.merge({ "title" => nil })
      end

      def length
        story.merge({ "title" => "a" * 257 })
      end

      def uri
        story.merge({ "url" => "http://www.getdropbox/u/2/screencast.html" })
      end

      def author
        story.merge({ "author" => '' })
      end

      def points
        story.merge({ "points" => 0 })
      end

      def comments
        story.merge({ "comments" => -1 })
      end
    end
  end
end
