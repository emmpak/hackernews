# frozen_string_literal: true

require('./models/top_stories')

describe TopStories do
  let(:url) { 'https://hacker-news.firebaseio.com/v0/topstories.json' }
  let(:top_stories) { Fixtures::HackerNewsResponse.top_stories }

  describe '#fetch' do
    before do
      @request = stub_request(:get, url).to_return(body: top_stories)
    end

    it 'makes a request to get the top stories' do
      expect(subject.fetch).to eq(JSON.parse(top_stories))
      expect(@request).to have_been_requested
    end

    it 'calls execute_again for retrial' do
      expect(subject).to receive(:execute_again)
      subject.fetch
    end
  end
end
