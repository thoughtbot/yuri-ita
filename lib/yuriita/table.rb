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
        input.strip
      end
    end

    def options_for(key)
      definition = configuration.find_definition(key)
      definition.view_options(query: query, param_key: param_key)
    end

    def items
      Runner.new(relation: relation, configuration: configuration).run(query)
    end

    def filtered?
      user_input.present?
    end

    private

    attr_reader :relation, :params, :configuration, :param_key

    def input
      user_input || default_input
    end

    def user_input
      params[param_key].presence
    end

    def default_input
      EMPTY_STRING
    end

    def query
      QueryBuilder.build(input)
    rescue ParseError
      Query.new
    end
  end
end
