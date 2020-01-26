module Yuriita
  class Result
    def self.error(exception)
      new(exception: exception)
    end

    def self.success(relation)
      new(relation: relation)
    end

    attr_reader :relation, :exception

    def initialize(relation: nil, exception: nil)
      @relation = relation
      @exception = exception

      if @relation.nil? && @exception.nil?
        raise ArgumentError, "Must provide a relation or an expression"
      end
    end

    def successful?
      exception.nil?
    end
  end
end
