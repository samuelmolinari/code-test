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
    private

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
