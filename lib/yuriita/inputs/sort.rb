module Yuriita
  module Inputs
    Sort = Struct.new(:qualifier, :term) do
      def to_s
        "#{qualifier}:#{term}"
      end
    end
  end
end
