module Yuriita
  module Selects
    class Single
      def initialize(options:, query:)
        @options = options
        @query = query
      end

      def filter
        if active_option.present?
          active_option.filter
        end
      end

      def selected?(option)
        if active_option.present?
          active_option == option
        else
          false
        end
      end

      private

      attr_reader :options, :query

      def active_option
        input = last_matching_input
        if input.present?
          option_for(input)
        end
      end

      def last_matching_input
        matching_inputs.last
      end

      def matching_inputs
        query.select do |input|
          options.any? { |option| option.input == input }
        end
      end

      def option_for(input)
        options.detect { |option| option.input == input }
      end
    end
  end
end
