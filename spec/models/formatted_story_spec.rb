# frozen_string_literal: true

require('./models/formatted_story')

describe FormattedStory do
  let(:story) { JSON.parse(Fixtures::HackerNewsResponse.story) }
  let(:formatted) do
    {
      'title' => 'My YC app: Dropbox - Throw away your USB drive',
      'uri' => 'http://www.getdropbox.com/u/2/screencast.html',
      'author' => 'dhouston',
      'points' => 111,
      'comments' => 71
    }
  end

  subject { described_class.new(story) }

  describe '#format' do
    it 'formats the story' do
      expect(subject.format).to eq(formatted)
    end
  end
end
