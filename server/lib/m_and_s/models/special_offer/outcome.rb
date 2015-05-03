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
    end
  end
end
