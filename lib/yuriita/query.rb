module Yuriita
  class Query
    attr_reader :keywords, :inputs

    def initialize(keywords: [], inputs: [])
      @keywords = keywords
      @inputs = inputs
    end
  end
end
