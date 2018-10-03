# frozen_string_literal: true

require('./models/story')

describe Story do
  let(:url) { 'https://hacker-news.firebaseio.com/v0/item/9129911.json' }
  let(:sample_story) { Fixtures::HackerNewsResponse.story }
  let(:rank) { { 'rank' => 2 } }

  let(:story) { described_class.new(9_129_911, 1) }

  describe '#info' do
    before do
      @request = stub_request(:get, url).to_return(body: sample_story)
    end

    it 'makes a request to get the selected story' do
      expect(story.info).to eq(JSON.parse(sample_story).merge(rank))
      expect(@request).to have_been_requested
    end

    it 'calls execute_again for retrial' do
      expect(story).to receive(:execute_again).and_call_original
      story.info
    end
  end
end
