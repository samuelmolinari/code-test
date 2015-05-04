require 'spec_helper'

describe ::MAndS::SpecialOffer::Criteria do
  let(:jeans) { build(:jeans) }
  let(:criteria) { MAndS::SpecialOffer::Criteria.new }

  before do
    @basket_struct = Struct.new(:basket) do
      def get
        basket
      end
    end
  end

  describe '#add' do
    it 'adds product and quantity to the criteria' do
      criteria.add(product: jeans, quantity: 2)
        .get(product: jeans).must_equal 2
    end

    describe 'when a product has already been added' do
      it 'sums the existing quantity with the given one' do
        criteria
          .add(product: jeans, quantity: 2)
          .add(product: jeans, quantity: 1)
          .get(product: jeans).must_equal 3
      end
    end
  end

  describe '#set' do
    it 'adds and replace any already existing quantity' do
      criteria.add(product: jeans, quantity: 2)
        .set(product: jeans, quantity: 1)
        .get(product: jeans).must_equal 1
    end
  end

  describe '#remove' do
    it 'removes the product if it exists' do
      criteria.add(product: jeans, quantity: 1)
        .remove(product: jeans)
        .get(product: jeans).must_equal 0
    end
  end

  describe '#valid?' do
    describe 'when invalid' do
      it 'has products with a quantity of zero or below' do
        criteria.set(product: jeans, quantity: -1)
          .valid?.wont_equal true

        criteria.set(product: jeans, quantity: 0)
          .valid?.wont_equal true
      end
    end
  end
    end
  end
end
