# frozen_string_literal: true

require('./processors/top_stories_request_processor')

describe TopStoriesRequestProcessor do
  let(:story)           { Fixtures::HackerNewsResponse.story }
  let(:formatted_story) { Fixtures::StoryExample.formatted_story }

  subject { described_class.new(FormattedStory, ResponseValidation) }

  describe '#execute' do
    context 'valid inputs' do
      it 'makes a request to get the top stories and details for a story with validations' do
        stub_const('ARGV', ['--posts', '1'])
        expect_any_instance_of(InputValidation).to receive(:validate)
        expect_any_instance_of(TopStories).to receive(:fetch).and_return([9_129_911])
        expect_any_instance_of(Story).to receive(:info).and_return(JSON.parse(story))
        expect_any_instance_of(FormattedStory).to receive(:format).and_return(formatted_story)
        expect_any_instance_of(ResponseValidation).to receive(:invalid?).and_return(false)
        expect { subject.execute }.to output("#{[formatted_story]}\n").to_stdout
      end

      it 'gets details for multiple stories' do
        stub_const('ARGV', ['--posts', '2'])
        allow_any_instance_of(InputValidation).to receive(:validate)
        allow_any_instance_of(TopStories).to receive(:fetch).and_return([9_129_911, 123])
        allow_any_instance_of(Story).to receive(:info).and_return(JSON.parse(story))
        allow_any_instance_of(FormattedStory).to receive(:format).and_return(formatted_story)
        allow_any_instance_of(ResponseValidation).to receive(:invalid?).and_return(false)
        expect { subject.execute }.to output("#{[formatted_story, formatted_story]}\n").to_stdout
      end
    end

    context 'error handling' do
      it 'rescues an InputError and outputs message to command line' do
        expect_any_instance_of(InputValidation).to receive(:validate).and_raise(InputError)
        expect { subject.execute }.to output.to_stdout
      end

      it 'rescues other errors' do
        stub_const('ARGV', ['--posts', '1'])
        allow_any_instance_of(TopStories).to receive(:fetch).and_raise(Faraday::ConnectionFailed, 'error')
        expect { subject.execute }.to output("Something went wrong. Please try again.\n").to_stdout
      end
    end
  end
end
