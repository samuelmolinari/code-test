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

    def valid?
      valid_name? && valid_code? && valid_price?
    end

    def valid_name?
      !name.nil? && !name.empty?
    end

    def valid_code?
      !code.nil? && !code.empty?
    end

    def valid_price?
      !price.nil? && price.cents > 0
    end
  end
end
