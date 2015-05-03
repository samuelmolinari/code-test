require 'money'

module MAndS
  # M&S product class
  class Product
    attr_accessor :name, :code, :price

    def initialize(name: '', code: '', price: Money.new(0, DEFAULT_CURRENCY))
      @name = name
      @code = code
      @price = price
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
