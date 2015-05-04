module MAndS
  # Basket class
  class Basket
    def initialize(products: [], delivery_charges: [], offers: [])
      fail ProductsError unless ProductsError.valid_products?(products)
      fail DeliveryChargesError unless
        DeliveryChargesError.valid_delivery_charges?(delivery_charges)
      fail SpecialOffersError unless SpecialOffersError.valid_offers?(offers)

      @catalog = build_catalog(products: products)
      @delivery_charges = delivery_charges.sort_by(&:min_spend)
      @offers = offers
      @basket = {}
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
        criteria_match_count = offer.criteria.match(basket: self)
        amount = 0
        if criteria_match_count > 0
          amount = offer.outcome.evaluate_discount_worth(
            basket: self,
            multiplier: criteria_match_count)
        end
        discount + amount
      end
    end

    def build_catalog(products: [])
      @catalog = Hash[products.collect { |item| [item.code, item] }]
    end

    ##
    # Product unknown error
    class UnknownProductError < Exception
      def initialize
        super('The catalog doesn not contain this product')
      end
    end

    ##
    # Catalog error raised when the catalog is invalid
    class ProductsError < Exception
      def initialize
        super('List of products  must be an array of minimum size 1,
              only containing products')
      end

      def self.valid_products?(products)
        products.is_a?(Array) && !products.empty? &&
          products.all? { |item| item.is_a?(Product) && item.valid? }
      end
    end

    ##
    # Delivery charges error raised when the list of delivery charges is invalid
    class DeliveryChargesError < Exception
      def initialize
        super('List of delivery charges can\'t contain other type of items')
      end

      def self.valid_delivery_charges?(delivery_charges)
        delivery_charges.is_a?(Array) && !delivery_charges.empty? &&
          delivery_charges.all? do |item|
            item.is_a?(DeliveryCharge) && item.valid?
          end
      end
    end

    ##
    # Special Offer error raised when the list of special offers is invalid
    class SpecialOffersError < Exception
      def initialize
        super('List of special offers can\'t contain other type of items
               (but it can be empty!)')
      end

      def self.valid_offers?(offer)
        offer.is_a?(Array) && (offer.empty? ||
          offer.all? { |item| item.is_a?(SpecialOffer) && item.valid? })
      end
    end
  end
end
