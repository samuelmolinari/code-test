FactoryGirl.define do
  factory :delivery_charge_below_50, class: ::MAndS::DeliveryCharge do
    min_spend Money.new(0, ::MAndS::DEFAULT_CURRENCY)
    cost Money.new(495, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :delivery_charge_below_90, class: ::MAndS::DeliveryCharge do
    min_spend Money.new(50, ::MAndS::DEFAULT_CURRENCY)
    cost Money.new(295, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :delivery_charge_above_90, class: ::MAndS::DeliveryCharge do
    min_spend Money.new(90, ::MAndS::DEFAULT_CURRENCY)
    cost Money.new(0, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :delivery_charge_without_minimum_spend,
          parent: :delivery_charge_below_50 do
    min_spend nil
  end

  factory :delivery_charge_with_minimum_spend_below_zero,
          parent: :delivery_charge_below_50 do
    min_spend Money.new(-1, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :delivery_charge_without_cost,
          parent: :delivery_charge_below_50 do
    cost nil
  end

  factory :delivery_charge_with_cost_below_zero,
          parent: :delivery_charge_below_50 do
    cost Money.new(-1, ::MAndS::DEFAULT_CURRENCY)
  end
end
