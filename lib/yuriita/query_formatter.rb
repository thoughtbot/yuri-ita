module Yuriita
  class QueryFormatter
    SPACE = " ".freeze

    def initialize(param_key:)
      @param_key = param_key
    end

    def format(query)
      value = query.each_element.map(&:to_s).join(SPACE)
      { param_key => value }
    end

    private

    attr_reader :param_key
  end
end
