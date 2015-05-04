require 'spec_helper'

describe ::MAndS::DeliveryCharge do
  describe 'delivery charge creation' do
    it 'can be initialised with a minimum spend value' do
      min_spend = Money.new(0, MAndS::DEFAULT_CURRENCY)
      MAndS::DeliveryCharge.new(min_spend: min_spend)
        .min_spend.must_equal min_spend
    end

    it 'can be initialised with a cost' do
      cost = Money.new(0, MAndS::DEFAULT_CURRENCY)
      MAndS::DeliveryCharge.new(cost: cost).cost.must_equal cost
    end
  end

  describe 'valid?' do
    describe 'when invalid' do
      it 'either has no minimum spend or the minimum spend is below zero' do
        build(:delivery_charge_without_minimum_spend).valid?.wont_equal true
        build(:delivery_charge_with_minimum_spend_below_zero)
          .valid?.wont_equal true
      end

      it 'either has no cost or the cost is below zero' do
        build(:delivery_charge_without_cost).valid?.wont_equal true
        build(:delivery_charge_with_cost_below_zero)
          .valid?.wont_equal true
      end
    end

    describe 'when valid' do
      it 'has a valid cost and a valid minimum spend' do
        build(:delivery_charge_below_50).valid?.must_equal true
        build(:delivery_charge_below_90).valid?.must_equal true
        build(:delivery_charge_above_90).valid?.must_equal true
      end
    end
  end
end
