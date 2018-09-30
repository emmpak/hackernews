# frozen_string_literal: true

require('./models/application')

describe Application do
  describe '#execute_again' do
    it 'raises an error if there was a problem with the connection' do
      expect { subject.execute_again { 'no error' } }.not_to raise_error
      expect { subject.execute_again { raise(Faraday::ConnectionFailed, 'error') } }
        .to raise_error('error')
    end
  end
end
