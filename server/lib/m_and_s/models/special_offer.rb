require_relative 'special_offer/criteria'
require_relative 'special_offer/outcome'

module MAndS
  ##
  # Special Offer Class
  #
  # A special offer is composed of a criteria and an outcome.
  # The criteria is what triggers the special offer,
  # the outcome is how the special offer should be applied.
  #
  # It gives room for a wild range of possibilities, for example:
  #
  # - Buy 2 pair of jeans, get a blouse half price
  #   - Criteria: 2 J01
  #   - Outcome: 1 B01, with a discount of 50%
  #
  # - Buy 2 pair of socks and 1 pair of jeans, get 1 pair of socks free
  #   - Criteria: 2 S01, 1 J01
  #   - Outcome: 1 J01, with a discount of 50%
  class SpecialOffer
    attr_accessor :criteria, :outcome

    def initialize(criteria: Criteria.new, outcome: Outcome.new)
      @criteria = criteria
      @outcome = outcome
    end

    def self.buy_one_get_one_half_price(product: nil)
      criteria = Criteria.new
      outcome = Outcome.new

      criteria.set(product: product, quantity: 2)
      outcome.set(product: product, quantity: 1, discount: 50)

      SpecialOffer.new(criteria: criteria, outcome: outcome)
    end

    def valid?
      criteria.valid? && outcome.valid?
    end
  end
end
