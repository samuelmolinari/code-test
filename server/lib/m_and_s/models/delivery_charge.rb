module MAndS
  # Delivery charge class
  class DeliveryCharge
    attr_accessor :min_spend, :cost

    def initialize(min_spend: nil, cost: nil)
      self.min_spend = min_spend
      self.cost = cost
    end

    def valid?
      valid_min_spend? && valid_cost?
    end

    def valid_min_spend?
      !min_spend.nil? && min_spend.cents >= 0
    end

    def valid_cost?
      !cost.nil? && cost.cents >= 0
    end
  end
end
