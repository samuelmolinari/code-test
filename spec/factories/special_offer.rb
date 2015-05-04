FactoryGirl.define do
  factory :criteria, class: ::MAndS::SpecialOffer::Criteria do
    after(:build) do |model, _|
      model.instance_variable_set(:@criteria_hash,
                                  FactoryGirl.build(:jeans).code => 1)
    end
  end

  factory :outcome, class: ::MAndS::SpecialOffer::Outcome do
    after(:build) do |model, _|
      model.instance_variable_set(:@outcome_hash,
                                  FactoryGirl.build(:jeans).code =>
      { quantity: 1, discount: 50 })
    end
  end

  factory :invalid_criteria, parent: :criteria do
    after(:build) do |model, _|
      model.instance_variable_set(:@criteria_hash,
                                  FactoryGirl.build(:jeans).code => -1)
    end
  end

  factory :invalid_outcome, parent: :outcome do
    after(:build) do |model, _|
      model.instance_variable_set(:@outcome_hash,
                                  FactoryGirl.build(:jeans).code =>
      { quantity: -1, discount: 0 })
    end
  end

  factory :invalid_offer, class: ::MAndS::SpecialOffer do
    after(:build) do |model, _|
      model.criteria = build(:invalid_criteria)
      model.outcome = build(:invalid_outcome)
    end
  end
end
