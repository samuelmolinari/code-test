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

      def evaluate_discount_worth(basket: nil, multiplier: 1)
        @outcome_hash.inject(Money.new(0,
                                       DEFAULT_CURRENCY)) do |discount, outcome|
          code, item = outcome

          discount + compute_product_discount_amount(
            price: basket.get_product(code: code).price,
            discount: item[:discount],
            quantity: item[:quantity],
            basket_quantity: basket.get[code],
            multiplier: multiplier)
        end
      end

      def valid?
        @outcome_hash.all? do |_, outcome|
          outcome[:quantity] > 0 &&
            outcome[:discount] > 0 && outcome[:discount] <= 100
        end
      end

      private

      def compute_product_discount_amount(price: nil, discount: 0, quantity: 0,
                                          basket_quantity: 0, multiplier: 0)
        amount = 0

        if basket_quantity.to_i > 0
          amount = price * (discount / 100.0) * [
            basket_quantity, quantity * multiplier].min
        end

        amount
      end
    end
  end
end
