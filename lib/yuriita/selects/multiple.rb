module Yuriita
  module Selects
    class Multiple
      def initialize(options:, query:)
        @options = options
        @query = query
      end

      def filters
        active_options.map(&:filter)
      end

      def selected?(option)
        active_options.include?(option)
      end

      private

      attr_reader :options, :query

      def active_options
        options.select do |option|
          query.include?(option.input)
        end
      end
    end
  end
end
