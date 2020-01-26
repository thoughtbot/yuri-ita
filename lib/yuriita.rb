require "yuriita/version"
require "yuriita/filter_methods"

require "yuriita/query"
require "yuriita/query/definition"

require "yuriita/filters/static"
require "yuriita/filters/value"

require "yuriita/clauses/where"
require "yuriita/clauses/where_not"
require "yuriita/clauses/noop"

module Yuriita
  class Error < StandardError; end

  extend FilterMethods
end
