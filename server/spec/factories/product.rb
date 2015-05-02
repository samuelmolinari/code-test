FactoryGirl.define do
  factory :product, class: ::MAndS::Product do
    name 'Product Name'
    code 'CODE1234'
    price Money.new(1000, ::MAndS::DEFAULT_CURRENCY)
  end

  factory :product_without_name, parent: :product do
    name nil
  end

  factory :product_with_empty_name, parent: :product do
    name ''
  end

  factory :product_without_code, parent: :product do
    code nil
  end

  factory :product_with_empty_code, parent: :product do
    code ''
  end

  factory :product_without_price, parent: :product do
    price nil
  end

  factory :free_product, parent: :product do
    price Money.new(0, 'GBP')
  end

  factory :product_with_price_below_zero, parent: :product do
    price Money.new(-1, 'GBP')
  end
end
