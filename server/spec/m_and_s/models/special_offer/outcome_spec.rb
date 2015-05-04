require 'spec_helper'

describe ::MAndS::SpecialOffer::Outcome do
  let(:jeans) { build(:jeans) }
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
      outcome.set(product: jeans, quantity: 1, discount: 50)
      outcome.remove(product: jeans)
      outcome.get(product: jeans).must_equal(quantity: 0, discount: 0)
    end
  end
end
