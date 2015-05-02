require 'money'

module MAndS
  # M&S product class
  class Product
    attr_accessor :name, :code, :price

    def initialize(name: nil, code: nil, price: nil)
      self.name = name
      self.code = code
      self.price = price
    end
  end
end
