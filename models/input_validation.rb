# frozen_string_literal: true

# Validates the command line inputs
class InputValidation
  attr_reader :flag, :posts

  def initialize(flag, posts)
    @flag = flag
    @posts = posts
  end

  def validate
    raise(InputError) if invalid_flag || invalid_number?
  end

  private

  def invalid_flag
    flag != '--posts'
  end

  def invalid_number?
    !posts.is_a?(Numeric) || posts.negative? || posts > 200
  end
end

class InputError < StandardError; end
