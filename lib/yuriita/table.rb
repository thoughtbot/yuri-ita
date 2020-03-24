require "active_support"
require "active_model"
require "yuriita/runner"

module Yuriita
  class Table
    include ActiveModel::Model

    SPACE = " ".freeze
    EMPTY_STRING = "".freeze

    def initialize(relation:, params:, configuration:, param_key: :q)
      @relation = relation
      @params = params
      @configuration = configuration
      @param_key = param_key
    end

    def q
      if input.present?
        input.strip + SPACE
      else
        input
      end
    end

    def options_for(key)
      definition = configuration.find_definition(key)
      definition.view_options(query: query, param_key: param_key)
    end

    def items
      Runner.new(relation: relation, configuration: configuration).run(query)
    end

    private

    attr_reader :relation, :params, :configuration, :param_key

    def input
      params[param_key] || EMPTY_STRING
    end

    def query
      QueryBuilder.build(input)
    rescue ParseError
      Query.new
    end
  end
end
