require "active_model"

module Yuriita
  class Search
    include ActiveModel::Model

    def initialize(table, param_key)
      define_singleton_method(param_key) do
        table.q
      end
    end
  end
end
