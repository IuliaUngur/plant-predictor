module Ap
  module Fuzzy
    class Distance
      def initialize
        define_axioms
        define_rules
      end

      def perform(value)
        @distance.get(value)
      end

      private

      def define_axioms
        @distance = FuzzyLogic::Collection.new("Distance") { |grad|
          o = false

          if grad.is_a? Numeric
            o = true if grad < 301 && grad > -1
          end
          o
        }
      end

      def define_rules
        # TODO: search for measurements for this values

        @distance[:overlap] = FuzzyLogic::Generate.trapezoid(-1,0,3,7)
        @distance[:close] = FuzzyLogic::Generate.trapezoid(5,10,20,30)
        @distance[:nearby] = FuzzyLogic::Generate.trapezoid(25,45,100,150)
        @distance[:in_range] = FuzzyLogic::Generate.trapezoid(125,140,200,275)
        @distance[:far] = FuzzyLogic::Generate.trapezoid(250,260,300,301)
      end
    end
  end
end
