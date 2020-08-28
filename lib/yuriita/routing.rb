module Yuriita
  module Routing
    extend ActiveSupport::Concern

    included do
      cattr_accessor :router, default: Yuriita::Router.new
    end

    class_methods do
      def routing(matcher, to:)
        router.append_route(self, matcher, to: to)
      end

      def route(input, relation)
        router.route(input, relation)
      end
    end
  end
end
