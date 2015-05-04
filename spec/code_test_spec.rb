require 'spec_helper'

describe 'M&S Digital Labs Code Test' do
  # Products
  let(:jeans) { build(:jeans) }
  let(:blouse) { build(:blouse) }
  let(:socks) { build(:socks) }
  let(:products) { [jeans, blouse, socks] }

  # Special Offers
  let(:offers) do
    [MAndS::SpecialOffer.buy_one_get_one_half_price(product: jeans)]
  end

  # Delivery Charges
  let(:delivery_charges) do
    [build(:delivery_charge_below_50),
     build(:delivery_charge_below_90),
     build(:delivery_charge_above_90)]
  end

  let(:basket) do
    MAndS::Basket.new(delivery_charges: delivery_charges,
                      offers: offers,
                      products: products)
  end

  describe 'when buying a pair of socks and a blouse' do
    before do
      basket.add(code: socks.code).add(code: blouse.code)
    end

    it 'has a basket total of £37.85' do
      basket.total.must_equal Money.new(3785, 'GBP')
    end
  end

  describe 'when buying 2 pairs of jeans' do
    before do
      basket.add(code: jeans.code).add(code: jeans.code)
    end

    it 'has a basket total of £54.37' do
      basket.total.must_equal Money.new(5437, 'GBP')
    end
  end

  describe 'when buying a pair of jeans and a blouse' do
    before do
      basket.add(code: jeans.code).add(code: blouse.code)
    end

    it 'has a basket total of £60.85' do
      basket.total.must_equal Money.new(6085, 'GBP')
    end
  end

  describe 'when buying 2 pairs of socks and 3 pairs of jeans' do
    before do
      basket.add(code: jeans.code)
        .add(code: jeans.code)
        .add(code: jeans.code)
        .add(code: socks.code)
        .add(code: socks.code)
    end

    it 'has a basket total of £98.27' do
      basket.total.must_equal Money.new(9827, 'GBP')
    end
  end
end
