# frozen_string_literal: true

require('./processors/top_stories_request_processor')

describe TopStoriesRequestProcessor do
  let(:story) { Fixtures::HackerNewsResponse.story }

  describe '#execute' do
    it 'makes a request to get the top stories and details for each story' do
      expect_any_instance_of(TopStories).to receive(:fetch).and_return([9_129_911])
      expect_any_instance_of(Story).to receive(:info).and_return(JSON.parse(story))
      expect_any_instance_of(FormattedStory).to receive(:format)
      subject.execute
    end
  end
end
