module Yuriita
  class Collection
    class ActionNotFound < Yuriita::Error
      attr_reader :collection, :action

      def initialize(message = nil, collection = nil, action = nil)
        @collection = collection
        @action = action
        super(message)
      end
    end
  end
end
