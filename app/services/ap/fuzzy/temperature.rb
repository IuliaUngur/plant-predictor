module Ap
  module Fuzzy
    class Temperature
      def initialize
        define_axioms
        define_rules
      end

      def perform(value)
        @temperature.get(value)
      end

      private

      def define_axioms
        @temperature = FuzzyLogic::Collection.new("Temperature") { |grad|
          o = false

          if grad.is_a? Numeric
            o = true if grad < 101 && grad > -101
          end
          o
        }
      end

      def define_rules
        # TODO: search for measurements for this values

        @temperature[:freeze] = FuzzyLogic::Generate.trapezoid(-101,-100,0,5)
        @temperature[:cold] = FuzzyLogic::Generate.triangle(3,9)
        @temperature[:cool] = FuzzyLogic::Generate.trapezoid(7,11,21,25)
        @temperature[:warm] = FuzzyLogic::Generate.triangle(23,28)
        @temperature[:hot] = FuzzyLogic::Generate.trapezoid(27,30,100,101)
      end
    end
  end
end
