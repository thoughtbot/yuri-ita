require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/yuri-ita.rb")
loader.collapse("#{__dir__}/yuriita/errors")
loader.setup

module Yuriita
  def self.filter(relation, input, configuration)
    query = build_query(input)
    relation = Runner.new(relation: relation, configuration: configuration).run(query)
    Result.success(relation)
  rescue ParseError => exception
    Result.error(exception)
  end

  def self.build_query(input)
    QueryBuilder.build(input)
  end
end

loader.eager_load
