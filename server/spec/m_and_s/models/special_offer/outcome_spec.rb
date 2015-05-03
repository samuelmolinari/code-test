require 'spec_helper'

describe ::MAndS::SpecialOffer::Outcome do
  let(:jeans) { build(:jeans) }
  let(:outcome) { MAndS::SpecialOffer::Outcome.new }

  describe '#set' do
    it 'returns the outcome' do
      outcome.set(product: jeans).must_equal outcome
    end

    it 'sets an outcome for a specific product' do
      outcome.set(product: jeans, quantity: 1, discount: 50)
      outcome.get(product: jeans).must_equal(quantity: 1, discount: 50)
    end
  end

  describe '#remove' do
    it 'returns the outcome' do
      outcome.remove(product: jeans).must_equal outcome
    end

    it 'removes the product from outcome if it exists' do
      outcome.set(product: jeans, quantity: 1, discount: 50)
      outcome.remove(product: jeans)
      outcome.get(product: jeans).must_equal(quantity: 0, discount: 0)
    end
  end
end
