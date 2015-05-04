module MAndS
  ##
  # Delivery charges error raised when the list of delivery charges is invalid
  class DeliveryChargesError < Exception
    def initialize
      super('List of delivery charges can\'t contain other type of items')
    end
  end
end
