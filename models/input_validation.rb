# frozen_string_literal: true

# Validates the command line inputs
class InputValidation
  attr_reader :flag, :posts

  def initialize(flag, posts)
    @flag = flag
    @posts = posts
  end

  def validate
    raise(InputError) unless valid_flag? && valid_number?
  end

  private

  def valid_flag?
    flag == '--posts'
  end

  def valid_number?
    integer? && within_range?(posts.to_i)
  end

  def integer?
    posts.to_i.to_f == posts.to_f
  end

  def within_range?(posts)
    posts.positive? && posts < 101
  end
end

class InputError < StandardError; end
