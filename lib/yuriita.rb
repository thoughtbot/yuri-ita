require "yuriita/version"
require "yuriita/errors"

require "yuriita/runner"
require "yuriita/query_builder"

require "yuriita/query"
require "yuriita/query/definition"

require "yuriita/or_combination"
require "yuriita/and_combination"

require "yuriita/expression_filter"
require "yuriita/keyword_filter"
require "yuriita/sorter"

require "yuriita/clauses/where"
require "yuriita/clauses/order"

module Yuriita
  def self.filter(relation, input, definition)
    query = build_query(input)
    relation = Runner.new(relation: relation, definition: definition).run(query)
    Result.success(relation)
  rescue ParseError => exception
    Result.error(exception)
  end

  def self.build_query(input)
    QueryBuilder.build(input)
  end
end
