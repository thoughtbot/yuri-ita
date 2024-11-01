module Yuriita
  class Router
    def initialize
      @routes = []
    end

    def append_route(collection, matcher, to:)
      routes.append Route.new(collection, matcher, to)
    end

    def route(input, relation)
      if (route = match_for(input))
        collection = route.collection
        collection.dispatch(route.action, input, relation)
      end
    end

    def match_for(input)
      routes.detect { |route| route.match?(input) }
    end

    private

    attr_reader :routes
  end
end
