# frozen_string_literal: true

require './models/top_stories'

describe TopStories do
  let(:url) { 'https://hacker-news.firebaseio.com/v0/topstories.json' }
  let(:top_stories) { Fixtures::HackerNewsResponse.top_stories }

  describe '#fetch' do
    it 'makes a request to get the top stories' do
      request = stub_request(:get, url).to_return(body: top_stories)
      expect(subject.fetch).to eq(top_stories)
      expect(request).to have_been_requested
    end
  end
end
