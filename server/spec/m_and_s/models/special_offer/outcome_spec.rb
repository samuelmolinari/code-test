require 'spec_helper'

describe ::MAndS::SpecialOffer::Outcome do
  let(:jeans) { build(:jeans) }
  let(:socks) { build(:socks) }
  let(:outcome) { MAndS::SpecialOffer::Outcome.new }

  before do
    @basket_struct = Struct.new(:basket, :catalog) do
      def get
        basket
      end

      def get_product(code: nil)
        catalog[code]
      end
    end
  end

  describe '#set' do
    it 'sets an outcome for a specific product' do
      outcome.set(product: jeans, quantity: 1, discount: 50)
        .get(product: jeans).must_equal(quantity: 1, discount: 50)
    end
  end

  describe '#remove' do
    it 'removes the product from outcome if it exists' do
      outcome.set(product: jeans, quantity: 1, discount: 50)
        .remove(product: jeans)
        .get(product: jeans).must_equal(quantity: 0, discount: 0)
    end
  end

  describe '#valid?' do
    describe 'when invalid' do
      it 'has products with a quantity of zero or below' do
        outcome.set(product: jeans, quantity: -1, discount: 1)
          .valid?.wont_equal true

        outcome.set(product: jeans, quantity: 0, discount: 1)
          .valid?.wont_equal true
      end

      it 'has products with a discount less than or equal to 0' do
        outcome.set(product: jeans, quantity: 1, discount: 0)
          .valid?.wont_equal true

        outcome.set(product: jeans, quantity: 1, discount: -1)
          .valid?.wont_equal true
      end

      it 'has products with a discount greater than 100' do
        outcome.set(product: jeans, quantity: 1, discount: 101)
          .valid?.wont_equal true
      end
    end
  end

  describe '#evaluate_discount_worth' do
    it 'returns discount to be applied to a basket' do
      outcome.set(product: jeans, quantity: 1, discount: 50)
        .evaluate_discount_worth(basket: @basket_struct.new(
          { jeans.code => 1 },
          jeans.code => jeans
        )).must_equal jeans.price * 0.5
    end

    it 'only compute discount for the expected quantity' do
      outcome.set(product: jeans, quantity: 2, discount: 50)
        .evaluate_discount_worth(basket: @basket_struct.new(
          { jeans.code => 4 },
          jeans.code => jeans
        )).must_equal jeans.price * 0.5 * 2
    end

    it 'only apply discount for product in basket' do
      outcome.set(product: jeans, quantity: 2, discount: 50)
        .evaluate_discount_worth(basket: @basket_struct.new(
          { jeans.code => 1 },
          jeans.code => jeans
        )).must_equal jeans.price * 0.5
    end

    it 'compute discount on multiple products' do
      outcome.set(product: jeans, quantity: 1, discount: 75)
        .set(product: socks, quantity: 1, discount: 100)
        .evaluate_discount_worth(basket: @basket_struct.new(
          { jeans.code => 1, socks.code => 1 },
          jeans.code => jeans, socks.code => socks
        )).must_equal jeans.price * 0.75 + socks.price
    end

    describe 'with multiplier' do
      it 'is is ignored when the quantity of product in the basket is lower' do
        outcome.set(product: jeans, quantity: 1, discount: 50)
          .evaluate_discount_worth(basket: @basket_struct.new(
            { jeans.code => 1 },
            jeans.code => jeans
          ), multiplier: 2).must_equal(jeans.price * 0.5)
      end

      it 'is applied when the quantity of products in the basket allows it' do
        outcome.set(product: jeans, quantity: 1, discount: 50)
          .evaluate_discount_worth(basket: @basket_struct.new(
            { jeans.code => 2 },
            jeans.code => jeans
          ), multiplier: 2).must_equal((jeans.price * 0.5) * 2)
      end
    end
  end
end
