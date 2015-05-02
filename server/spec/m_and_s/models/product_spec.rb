require 'spec_helper'

describe ::MAndS::Product do
  describe 'product creation' do
    it 'can be initialised with a name' do
      name = 'Product Name'
      MAndS::Product.new(name: name).name.must_equal name
    end

    it 'can be initialised with a code' do
      code = 'CODE1234'
      MAndS::Product.new(code: code).code.must_equal code
    end

    it 'can be initialised with a price' do
      price = Money.new(1000, 'GBP')
      MAndS::Product.new(price: price).price.must_equal price
    end
  end
end
