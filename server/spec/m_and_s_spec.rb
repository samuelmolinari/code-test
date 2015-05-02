require 'spec_helper'

describe ::MAndS do
  it 'has a GBP as default currency' do
    MAndS::DEFAULT_CURRENCY.must_equal 'GBP'
  end
end
