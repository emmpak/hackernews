# frozen_string_literal: true

require('./models/response_validation')

describe ResponseValidation do
  shared_examples '#invalid?' do |story, boolean|
    it 'returns false if story is invalid' do
      expect(described_class.new(story).invalid?).to be(boolean)
    end
  end

  Fixtures::StoryExample.invalid.each do |story|
    it_behaves_like('#invalid?', story, true)
  end

  Fixtures::StoryExample.valid.each do |story|
    it_behaves_like('#invalid?', story, false)
  end
end
