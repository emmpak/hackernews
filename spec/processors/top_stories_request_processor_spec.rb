# frozen_string_literal: true

require('./processors/top_stories_request_processor')

describe TopStoriesRequestProcessor do
  let(:story)           { Fixtures::HackerNewsResponse.story }
  let(:formatted_story) { Fixtures::InvalidStory.story }

  describe '#execute' do
    context 'valid inputs' do
      it 'makes a request to get the top stories and details for each story' do
        expect_any_instance_of(InputValidation).to receive(:validate)
        expect_any_instance_of(TopStories).to receive_message_chain(:fetch, :[]).and_return([9_129_911])
        expect_any_instance_of(Story).to receive(:info).and_return(JSON.parse(story))
        expect_any_instance_of(FormattedStory).to receive(:format).and_return(formatted_story)
        expect_any_instance_of(ResponseValidation).to receive(:validate_stories).and_return([formatted_story])
        expect { subject.execute }.to output([formatted_story].to_json + "\n").to_stdout
      end
    end

    context 'invalid inputs' do
      it 'rescues an InputError and outputs message to command line' do
        expect_any_instance_of(InputValidation).to receive(:validate).and_raise(InputError)
        expect { subject.execute }.to output.to_stdout
      end
    end
  end
end
