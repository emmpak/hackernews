# frozen_string_literal: true

require('./models/story')

describe Story do
  let(:url) { 'https://hacker-news.firebaseio.com/v0/item/8863.json' }
  let(:sample_story) { Fixtures::HackerNewsResponse.story }

  let(:story) { described_class.new(8863) }

  describe '#get_info' do
    before do
      @request = stub_request(:get, url).to_return(body: sample_story)
    end

    it 'makes a request to get the selected story' do
      expect(story.info).to eq(JSON.parse(sample_story))
      expect(@request).to have_been_requested
    end

    it 'calls execute_again for retrial' do
      expect(story).to receive(:execute_again)
      story.info
    end
  end
end
