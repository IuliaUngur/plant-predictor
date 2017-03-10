module Ap
  module Fuzzy
    class Light
      def initialize
        define_axioms
        define_rules
      end

      def perform(value)
        @light.get(value)
      end

      private

      def define_axioms
        @light = FuzzyLogic::Collection.new("Light") { |grad|
          o = false

          if grad.is_a? Numeric
            o = true if grad < 1025 && grad > -1
          end
          o
        }
      end

      def define_rules
        # TODO: search for measurements for this values

        @light[:dark] = FuzzyLogic::Generate.trapezoid(-1,0,300,350)
        @light[:moonlight] = FuzzyLogic::Generate.trapezoid(325,400,500,600)
        @light[:fog] = FuzzyLogic::Generate.triangle(550,650)
        @light[:clear] = FuzzyLogic::Generate.trapezoid(625,650,725,850)
        @light[:sunny] = FuzzyLogic::Generate.trapezoid(750,900,1024,1025)
      end
    end
  end
end
