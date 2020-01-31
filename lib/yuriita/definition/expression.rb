require "active_support/core_ext/string/filters"

module Yuriita
  module Definition
    class Expression
      VALID_REGEX = /^[a-z]+:[a-z]+$/

      def initialize(string)
        if !string.is_a?(String)
          raise ArgumentError, <<-ERROR.squish
            Definition expression must be a string,
            received #{string.class} instead
          ERROR
        end

        if !VALID_REGEX.match?(string)
          raise ArgumentError, <<-ERROR.squish
            Invalid definition expression "#{string}".
            Expression should take the form "qualifier:term"
          ERROR
        end

        @qualifier, @term = string.strip.split(":")
      end

      def match?(query_expression)
        query_expression.qualifier == qualifier && query_expression.term == term
      end

      def ==(other)
        other.is_a?(self.class) &&
          qualifier == other.qualifier &&
          term == other.term
      end

      protected

      attr_reader :qualifier, :term
    end
  end
end
