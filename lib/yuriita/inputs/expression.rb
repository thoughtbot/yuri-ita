module Yuriita
  module Inputs
    Expression = Struct.new(:qualifier, :term) do
      def to_s
        if term.match?(" ")
          "#{qualifier}:\"#{term}\""
        else
          "#{qualifier}:#{term}"
        end
      end
    end
  end
end
