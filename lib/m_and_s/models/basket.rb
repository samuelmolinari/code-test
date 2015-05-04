module MAndS
  # Basket class
  class Basket
    def initialize(products: [], delivery_charges: [], offers: [])
      fail ProductsError unless valid_products?(products)
      fail DeliveryChargesError unless valid_delivery_charges?(delivery_charges)
      fail SpecialOffersError unless valid_offers?(offers)

      @offers, @basket = offers, {}

      # Improve products accessibility
      @catalog = build_catalog(products: products)

      # Order delivery charges by min_spend to work with algorithm
      @delivery_charges = delivery_charges.sort_by(&:min_spend)
    end

    def add(code: nil)
      product = get_product(code: code)
      fail UnknownProductError unless product.is_a? Product
      @basket[code] = (@basket[code] || 0) + 1
      self
    end

    def get_product(code: nil)
      @catalog[code]
    end

    def get
      @basket
    end

    def sub_total
      @basket.inject(Money.new(0, DEFAULT_CURRENCY)) do |sub_total, item|
        product_code, quantity = item
        sub_total + (get_product(code: product_code).price * quantity)
      end
    end

    def total
      total = sub_total - discount_worth
      delivery_charge = delivery_charge(amount: total)

      total + delivery_charge
    end

    private

    def delivery_charge(amount: 0)
      cost = 0

      # Go through each delivery minimum spend value, until the amount of the
      # basket is lower than the required minimum spend
      @delivery_charges.each do |delivery_charge|
        if amount >= delivery_charge.min_spend
          cost = delivery_charge.cost
        else
          break
        end
      end

      cost
    end

    def discount_worth
      @offers.inject(Money.new(0, DEFAULT_CURRENCY)) do |discount, offer|
        amount = 0

        # Check if the offers criteria matches the current basket,
        # if it does, apply the offer's outcome
        criteria_match_count = offer.criteria.match(basket: self)
        if criteria_match_count > 0
          amount = offer.outcome.evaluate_discount_worth(
            basket: self,
            multiplier: criteria_match_count)
        end

        discount + amount
      end
    end

    def build_catalog(products: [])
      Hash[products.collect { |item| [item.code, item] }]
    end

    def valid_delivery_charges?(delivery_charges)
      delivery_charges.is_a?(Array) && !delivery_charges.empty? &&
        delivery_charges.all? do |item|
          item.is_a?(DeliveryCharge) && item.valid?
        end
    end

    def valid_products?(products)
      products.is_a?(Array) && !products.empty? &&
        products.all? { |item| item.is_a?(Product) && item.valid? }
    end

    def valid_offers?(offer)
      offer.is_a?(Array) && (offer.empty? ||
        offer.all? { |item| item.is_a?(SpecialOffer) && item.valid? })
    end
  end
end
