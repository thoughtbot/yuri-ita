module Yuriita
  class Collection
    include Yuriita::Routing

    attr_reader :input

    class << self
      def dispatch(name, input, relation)
        new(input).dispatch(name, relation)
      end

      def action_methods
        @action_methods ||= begin
          internal_methods = superclass.public_instance_methods(true)
          methods = (public_instance_methods(true) - internal_methods)

          methods.map!(&:to_s)

          methods.to_set
        end
      end
    end

    def initialize(input)
      @input = input
    end

    def dispatch(name, relation)
      process(name, relation)
    end

    private

    def process(action, *)
      action = action.to_s

      unless (method_name = find_method_name(action))
        raise ActionNotFound.new("The action '#{action}' could not be found for #{self.class.name}", self, action)
      end

      process_action(method_name, *)
    end

    def process_action(method_name, *)
      send_action(method_name, *)
    end
    alias_method :send_action, :send

    def find_method_name(action)
      if action_method?(action)
        action
      end
    end

    def action_method?(name)
      self.class.action_methods.include?(name)
    end
  end
end
