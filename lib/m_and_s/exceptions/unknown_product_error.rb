module MAndS
  ##
  # Unknown Product Error
  class UnknownProductError < Exception
    def initialize
      super('Product does not exists')
    end
  end
end
