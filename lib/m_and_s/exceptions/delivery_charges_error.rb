module MAndS
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
end
