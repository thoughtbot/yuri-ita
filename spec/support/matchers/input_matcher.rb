module Yuriita
  module Matchers

    def an_input_matching(qualifier, term)
      InputMatcher.new(qualifier, term)
    end
    alias_method :match_input, :an_input_matching


    class InputMatcher
      include RSpec::Matchers::Composable

      attr_reader :expected, :actual

      def initialize(qualifier, term)
        @qualifier = qualifier
        @term = term
        @expected = Yuriita::Query::Input.new(qualifier: qualifier, term: term)
        @mismatched_kind = false
      end

      def matches?(actual)
        @actual = actual
        match
      end

      def description
        "an input matching (qualifier: #{qualifier}, term: #{term})"
      end

      def failure_message
        if @mismatched_kind
          "expected a Yuriita::Query::Input but got #{actual.class} instead"
        else
          "expected the attributes to match"
        end
      end

      private

      attr_reader :qualifier, :term

      def match
        is_input? && attributes_match?
      end

      def is_input?
        if actual.kind_of?(Yuriita::Query::Input)
          true
        else
          @mismatched_kind = true
          false
        end
      end

      def attributes_match?
        expected.qualifier == actual.qualifier &&
          expected.term == actual.term
      end
    end
  end
end
