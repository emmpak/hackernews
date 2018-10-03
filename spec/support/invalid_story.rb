# frozen_string_literal: true

# Examples of HackerNews API responses
module Fixtures
  class InvalidStory
    class << self
      def story
        {
          'title' => 'My YC app: Dropbox - Throw away your USB drive',
          'uri' => 'http://www.getdropbox.com/u/2/screencast.html',
          'author' => 'dhouston',
          'points' => 111,
          'comments' => 71,
          'rank' => 2
        }
      end

      def title
        story.merge({ "title" => nil })
      end

      def length
        story.merge({ "title" => "a" * 257 })
      end

      def uri
        story.merge({ "uri" => "http://www.getdropbox/u/2/screencast.html" })
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

      def rank
        story.merge({ "rank" => 2 })
      end
    end
  end
end
