# frozen_string_literal: true

require('faraday')
require('uri')
require('json')

# Shared connection functionality
class Application
  def execute_again
    executed = false

    begin
      yield
    rescue Faraday::ConnectionFailed,
           Faraday::TimeoutError,
           Faraday::SSLError => e
      puts('Connection to HackerNews failed.')
      raise(e) if executed

      executed = true
      retry
    end
  end
end
