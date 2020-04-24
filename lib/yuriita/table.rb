require "active_support"
require "active_model"
require "yuriita/runner"

module Yuriita
  class Table
    include ActiveModel::Model

    SPACE = " ".freeze
    EMPTY_STRING = "".freeze

    def initialize(
      relation:,
      params:,
      configuration:,
      param_key: :q
    )
      @relation = relation
      @params = params
      @configuration = configuration
      @param_key = param_key

      alias :"#{param_key}" :q
    end

    def q
      output =
        if user_input?
          user_input
        else
          default_input
        end

      if output.blank?
        EMPTY_STRING
      else
        output + SPACE
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
      user_input? && user_query != default_query
    end

    def default_input
      configuration.default_input
    end

    private

    attr_reader :relation, :params, :configuration, :param_key

    def query
      if user_input?
        user_query
      else
        default_query
      end
    end

    def user_input
      params.fetch(param_key, EMPTY_STRING)
    end

    def user_input?
      params.key?(param_key)
    end

    def default_query
      QueryBuilder.build(default_input)
    end

    def user_query
      QueryBuilder.build(user_input)
    rescue ParseError
      Query.new
    end
  end
end
