module Yuriita
  class ViewOption
    attr_reader :name, :selected, :params

    def initialize(name:, selected:, params:)
      @name = name
      @selected = selected
      @params = params
    end

    def selected?
      selected
    end
  end
end
