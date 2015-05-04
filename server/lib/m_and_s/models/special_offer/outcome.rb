module MAndS
  class SpecialOffer
    # Special offer outcome class
    class Outcome
      def initialize
        @outcome_hash = {}
      end

      def set(product: nil, quantity: 1, discount: 0)
        @outcome_hash[product.code] = { quantity: quantity, discount: discount }
        self
      end

      def get(product: nil)
        @outcome_hash[product.code] || { quantity: 0, discount: 0 }
      end

      def remove(product: nil)
        @outcome_hash.delete(product.code)
        self
      end

      def valid?
        @outcome_hash.all? do |_, outcome|
          outcome[:quantity] > 0 &&
            outcome[:discount] > 0 && outcome[:discount] <= 100
        end
      end
    end
  end
end
