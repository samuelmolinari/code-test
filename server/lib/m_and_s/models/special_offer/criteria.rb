module MAndS
  class SpecialOffer
    # Special offer criteria class
    class Criteria
      def initialize
        @criteria_hash = {}
      end

      def add(product: nil, quantity: 1)
        @criteria_hash[product.code] =
          (@criteria_hash[product.code] || 0) + quantity
        self
      end

      def set(product: nil, quantity: 1)
        @criteria_hash[product.code] = quantity
        self
      end

      def get(product: nil)
        @criteria_hash[product.code] || 0
      end

      def remove(product: nil)
        @criteria_hash.delete(product.code)
        self
      end

      def valid?
        @criteria_hash.all? { |_, qty| qty > 0 }
      end
    end
  end
end
