require "rltk"

module Tokens
  def tokens(*tokens)
    tokens.map.with_index do |token, i|
      type, value = token
      length = (value || "").length
      pos = RLTK::StreamPosition.new(i, 1, i, length, nil)
      RLTK::Token.new(type, value, pos)
    end
  end
end

RSpec.configure do |config|
  config.include Tokens
end
