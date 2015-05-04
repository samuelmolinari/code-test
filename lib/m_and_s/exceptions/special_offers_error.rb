module MAndS
  ##
  # Special Offer error raised when the list of special offers is invalid
  class SpecialOffersError < Exception
    def initialize
      super('List of special offers can\'t contain other type of items
             (but it can be empty!)')
    end
  end
end
