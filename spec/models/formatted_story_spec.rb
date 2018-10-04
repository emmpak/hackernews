# frozen_string_literal: true

require('./models/formatted_story')

describe FormattedStory do
  let(:story) { Fixtures::StoryExample.story }
  let(:formatted_story) { Fixtures::StoryExample.formatted_story }

  subject { described_class.new(story) }

  describe '#format' do
    it 'formats the story' do
      expect(subject.format).to eq(formatted_story)
    end

    it 'updates the length' do
      story['title'] = 'a' * 257
      expect(JSON.parse(subject.format)['title']).to eq('a' * 253 + '...')
    end
  end
end
