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

      def match(basket: nil)
        match_count = nil

        @criteria_hash.each do |code, required_qty|
          basket_qty = basket.get[code]

          next unless basket_qty.to_i > 0

          product_match = basket_qty / required_qty
          match_count = match_count.nil? ? product_match : [product_match,
                                                            match_count].min
        end

        match_count.to_i
      end

      def valid?
        @criteria_hash.all? { |_, qty| qty > 0 }
      end
    end
  end
end
