require 'spec_helper'

describe ::MAndS::Basket do
  # Products
  let(:jeans) { build(:jeans) }
  let(:blouse) { build(:blouse) }
  let(:socks) { build(:socks) }
  let(:products) { [jeans, blouse, socks] }
  let(:catalog) do
    { jeans.code => jeans, blouse.code => blouse, socks.code => socks }
  end

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

  describe 'basket creation' do
    describe 'products parameter' do
      it 'is invalid without products' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: offers)
        end.must_raise MAndS::Basket::ProductsError
      end

      it 'is invalid when containing non product items' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: offers,
                            products: [jeans, Object.new, 'test'])
        end.must_raise MAndS::Basket::ProductsError
      end

      it 'is invalid when empty' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: offers,
                            products: [])
        end.must_raise MAndS::Basket::ProductsError
      end

      it 'is invalid when some products are invalid' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: offers,
                            products: [build(:product_without_name)])
        end.must_raise MAndS::Basket::ProductsError
      end
    end

    describe 'delivery charges parameter' do
      it 'is invalid without delivery charges' do
        proc do
          MAndS::Basket.new(products: products,
                            offers: offers)
        end.must_raise MAndS::Basket::DeliveryChargesError
      end

      it 'is invalid when containing non delivery charge items' do
        proc do
          MAndS::Basket.new(delivery_charges: ['test', Object.new],
                            offers: offers,
                            products: products)
        end.must_raise MAndS::Basket::DeliveryChargesError
      end

      it 'is invalid when empty' do
        proc do
          MAndS::Basket.new(delivery_charges: [],
                            offers: offers,
                            products: products)
        end.must_raise MAndS::Basket::DeliveryChargesError
      end

      it 'is invalid when some delivery charges are invalid' do
        proc do
          MAndS::Basket.new(delivery_charges:
                            [build(:delivery_charge_without_cost)],
                            offers: offers,
                            products: products)
        end.must_raise MAndS::Basket::DeliveryChargesError
      end
    end

    describe 'offers parameter' do
      it 'is invalid when containing non offer items' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: ['hi', Object.new],
                            products: products)
        end.must_raise MAndS::Basket::SpecialOffersError
      end

      it 'is invalid when containing invalid offers' do
        proc do
          MAndS::Basket.new(delivery_charges: delivery_charges,
                            offers: [build(:invalid_offer)],
                            products: products)
        end.must_raise MAndS::Basket::SpecialOffersError
      end
    end

    describe 'with valid arguments' do
      it 'create a basket instance' do
        basket.instance_variable_get('@offers').must_equal offers
        basket.instance_variable_get('@delivery_charges')
          .must_equal delivery_charges
        basket.instance_variable_get('@catalog').must_equal catalog
        basket.get.must_equal({})
      end
    end
  end

  describe '#get_product' do
    it 'returns the product matching the code' do
      basket.get_product(code: jeans.code).must_equal jeans
      basket.get_product(code: 'NA').must_equal nil
    end
  end
end