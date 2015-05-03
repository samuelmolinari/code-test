require 'spec_helper'

describe ::MAndS::SpecialOffer::Criteria do
  let(:jeans) { build(:jeans) }
  let(:criteria) { MAndS::SpecialOffer::Criteria.new }

  describe '#add' do
    it 'returns the criteria' do
      criteria.add(product: jeans).must_equal criteria
    end

    it 'adds product and quantity to the criteria' do
      criteria.add(product: jeans, quantity: 2)
      criteria.get(product: jeans).must_equal 2
    end

    describe 'when a product has already been added' do
      it 'sums the existing quantity with the given one' do
        criteria
          .add(product: jeans, quantity: 2)
          .add(product: jeans, quantity: 1)
        criteria.get(product: jeans).must_equal 3
      end
    end
  end

  describe '#set' do
    it 'returns the criteria' do
      criteria.set(product: jeans).must_equal criteria
    end

    it 'adds and replace any already existing quantity' do
      criteria.add(product: jeans, quantity: 2)
      criteria.set(product: jeans, quantity: 1)
      criteria.get(product: jeans).must_equal 1
    end
  end

  describe '#remove' do
    it 'returns the criteria' do
      criteria.remove(product: jeans).must_equal criteria
    end

    it 'removes the product if it exists' do
      criteria.add(product: jeans, quantity: 1)
      criteria.remove(product: jeans)
      criteria.get(product: jeans).must_equal 0
    end
  end
end
