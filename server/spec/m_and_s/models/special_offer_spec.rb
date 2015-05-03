require 'spec_helper'

describe ::MAndS::SpecialOffer do
  let(:product) { build(:jeans) }

  describe 'special offer creation' do
    it 'can be initialised with a criteria' do
      criteria = build(:criteria)
      MAndS::SpecialOffer.new(criteria: criteria)
        .criteria.must_equal criteria
    end
    it 'can be initialised with an outcome' do
      outcome = build(:outcome)
      MAndS::SpecialOffer.new(outcome: outcome)
        .outcome.must_equal outcome
    end
  end

  describe '.buy_one_get_one_half_price' do
    let(:offer) do
      MAndS::SpecialOffer.buy_one_get_one_half_price(product: product)
    end

    it 'has a criteria containing 2 of the given product' do
      offer.criteria.get(product: product).must_equal 2
    end

    it 'has an outcome containing 1 of the given product' do
      offer.outcome.get(product: product)[:quantity].must_equal 1
    end

    it 'has an outcome with a 50% discount on the given product' do
      offer.outcome.get(product: product)[:discount].must_equal 50
    end
  end
end
