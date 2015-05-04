module MAndS
  ##
  # Load all exceptions
  module Exceptions
    require_relative 'exceptions/unknown_product_error'
    require_relative 'exceptions/products_error'
    require_relative 'exceptions/special_offers_error'
    require_relative 'exceptions/delivery_charges_error'
  end
end
