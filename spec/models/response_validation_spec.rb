# frozen_string_literal: true

require('./models/response_validation')

describe ResponseValidation do
  let(:invalid_story) do
    {
      'title' => nil,
      'uri' => 'http://www.getdropbox/u/2/screencast.html',
      'author' => '',
      'points' => 111,
      'comments' => 71
    }
  end

  subject { described_class.new(invalid_story) }

  describe '#validate_and_update' do
    context 'when story contains invalid values' do
      before do
        subject.validate_and_update
      end

      it 'validates that there are no missing details' do
        expect(invalid_story.value?('')).to be false
        expect(invalid_story.value?(nil)).to be false
      end

      it 'validates the uri' do
        expect(invalid_story['uri']).to eq('Invalid URI')
      end
    end

    context 'when story is valid' do
      let(:story) do
        {
          'title' => 'My YC app: Dropbox - Throw away your USB drive',
          'uri' => 'http://www.getdropbox.com/u/2/screencast.html',
          'author' => 'dhouston',
          'points' => 111,
          'comments' => 71
        }
      end

      it 'does not updates any values' do
        instance = described_class.new(story)
        instance.validate_and_update
        expect(instance.story).to eq(story)
      end
    end
  end
end
