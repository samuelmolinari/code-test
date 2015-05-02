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
      price = Money.new(1000, MAndS::DEFAULT_CURRENCY)
      MAndS::Product.new(price: price).price.must_equal price
    end
  end

  describe '#valid?' do
    describe 'when invalid' do
      it 'either has no name or an empty name' do
        build(:product_without_name).valid?.wont_equal true
        build(:product_with_empty_name).valid?.wont_equal true
      end

      it 'either has no code or an empty code' do
        build(:product_without_code).valid?.wont_equal true
        build(:product_with_empty_code).valid?.wont_equal true
      end

      it 'either has no price, is free or has a price below zero' do
        build(:product_without_price).valid?.wont_equal true
        build(:free_product).valid?.wont_equal true
        build(:product_with_price_below_zero).valid?.wont_equal true
      end
    end

    describe 'when valid' do
      it 'has a valid name, code and price' do
        build(:jeans).valid?.must_equal true
        build(:socks).valid?.must_equal true
        build(:blouse).valid?.must_equal true
      end
    end
  end
end
