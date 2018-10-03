# frozen_string_literal: true

require('./models/response_validation')

describe ResponseValidation do
  let(:invalid_stories) do
    [
      Fixtures::InvalidStory.story,
      Fixtures::InvalidStory.title,
      Fixtures::InvalidStory.author,
      Fixtures::InvalidStory.length,
      Fixtures::InvalidStory.uri,
      Fixtures::InvalidStory.story,
      Fixtures::InvalidStory.points,
      Fixtures::InvalidStory.comments,
      Fixtures::InvalidStory.rank
    ]
  end

  subject { described_class.new(invalid_stories) }

  describe '#validate_stories' do
    it 'returns valid stories' do
      validated = subject.validate_stories
      expect(validated.length).to eq(5)
      expect(validated[0]).to eq(invalid_stories[0])
      expect(validated[-1]).to eq(invalid_stories[0])
      expect(validated[1]['title'].length).to eq(256)
    end
  end
end
