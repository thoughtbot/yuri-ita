require "yuriita/version"
require "yuriita/filter_methods"

require "yuriita/query"
require "yuriita/query_definition"

require "yuriita/filters/fixed_condition"
require "yuriita/filters/value_condition"

require "yuriita/clauses/where"
require "yuriita/clauses/where_not"
require "yuriita/clauses/noop"

module Yuriita
  class Error < StandardError; end

  extend FilterMethods
end
