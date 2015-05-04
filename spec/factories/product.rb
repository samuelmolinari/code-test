FactoryGirl.define do
  factory :jeans, class: ::MAndS::Product do
    name 'Jeans'
    code 'J01'
    price Money.new(3295, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :blouse, class: ::MAndS::Product do
    name 'Blouse'
    code 'B01'
    price Money.new(2495, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :socks, class: ::MAndS::Product do
    name 'Socks'
    code 'S01'
    price Money.new(795, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :product_without_name, parent: :jeans do
    name nil
  end

  factory :product_with_empty_name, parent: :jeans do
    name ''
  end

  factory :product_without_code, parent: :jeans do
    code nil
  end

  factory :product_with_empty_code, parent: :jeans do
    code ''
  end

  factory :product_without_price, parent: :jeans do
    price nil
  end

  factory :free_product, parent: :jeans do
    price Money.new(0, 'GBP')
  end

  factory :product_with_price_below_zero, parent: :jeans do
    price Money.new(-1, 'GBP')
  end
end
