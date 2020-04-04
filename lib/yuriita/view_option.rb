module Yuriita
  class ViewOption

    def initialize(option:, selector:, parameters:)
      @option = option
      @selector = selector
      @parameters = parameters
    end

    def name
      option.name
    end

    def selected?
      selector.selected?(option)
    end

    def params
      if selected?
        parameters.deselect(option.input)
      else
        parameters.select(option.input)
      end
    end

    private

    attr_reader :option, :selector, :parameters
  end
end
