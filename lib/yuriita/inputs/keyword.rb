module Yuriita
  module Inputs
    Keyword = Struct.new(:value) do
      def to_s
        value
      end
    end
  end
end
