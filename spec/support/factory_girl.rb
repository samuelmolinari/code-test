require 'factory_girl'

module MiniTest
  # Include factory girl syntax to minitest spec
  class Spec
    include ::FactoryGirl::Syntax::Methods
  end
end
