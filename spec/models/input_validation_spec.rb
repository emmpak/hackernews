# frozen_string_literal: true

require('./models/input_validation')

describe InputValidation do
  describe '#validate' do
    context 'flag check' do
      it 'notifies that the flag is invalid' do
        expect { described_class.new('--post', 1).validate }.to raise_error(InputError)
      end

      it 'returns stories if the flag is correct' do
        expect { described_class.new('--posts', 1).validate }.not_to raise_error(InputError)
      end
    end

    context 'posts number check' do
      it 'notifies that the number is invalid' do
        expect { described_class.new('--posts', -1).validate }.to raise_error(InputError)
        expect { described_class.new('--posts', 's').validate }.to raise_error(InputError)
      end

      it 'returns stories if the number is valid' do
        expect { described_class.new('--posts', 1).validate }.not_to raise_error(InputError)
      end
    end
  end
end
