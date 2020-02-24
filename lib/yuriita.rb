require "yuriita/version"
require "yuriita/filter_methods"

require "yuriita/query"
require "yuriita/query/definition"

require "yuriita/or_combination"
require "yuriita/and_combination"

require "yuriita/expression_filter"
require "yuriita/keyword_search"

require "yuriita/clauses/where"
require "yuriita/clauses/where_not"

module Yuriita
  class Error < StandardError; end

  extend FilterMethods
end
