module Ap
  module Fuzzy
    class Raindrop
      def initialize
        define_axioms
        define_rules
      end

      def perform(value)
        @raindrop.get(value)
      end

      private

      def define_axioms
        @raindrop = FuzzyLogic::Collection.new("Raindrop") { |grad|
          o = false

          if grad.is_a? Numeric
            o = true if grad < 1025 && grad > -1
          end
          o
        }
      end

      def define_rules
        # TODO: search for measurements for this values

        @raindrop[:dry] = FuzzyLogic::Generate.trapezoid(-101,-100,0,5)
        @raindrop[:condense] = FuzzyLogic::Generate.triangle(3,9)
        @raindrop[:drizzle] = FuzzyLogic::Generate.trapezoid(7,11,21,25)
        @raindrop[:heavy_rain] = FuzzyLogic::Generate.triangle(23,28)
        @raindrop[:flood] = FuzzyLogic::Generate.trapezoid(27,30,100,1024)
      end
    end
  end
end
