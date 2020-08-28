module Yuriita
  class Route
    attr_reader :collection

    def initialize(collection, matcher, to)
      @collection = collection
      @matcher = matcher
      @to = to
    end

    def match?(input)
      case matcher
      when String
        # TODO better matching
        # This won't work for string matching becuase to_s will use quotes
        # Could we parse it and compare the queries? This would maybe let us
        # catch parse exceptions
        #
        # If we do parse the matcher we could warn if it resulted in more than
        # two inputs.
        input.to_s == matcher
      when Proc
        matcher.call(input)
      else
        matcher.match?(input)
      end
    end

    def action
      to
    end

    private

    attr_reader :matcher, :to
  end
end
