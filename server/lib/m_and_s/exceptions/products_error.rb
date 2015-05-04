module MAndS
  ##
  # Catalog error raised when the catalog is invalid
  class ProductsError < Exception
    def initialize
      super('List of products  must be an array of minimum size 1,
            only containing products')
    end

    def self.valid_products?(products)
      products.is_a?(Array) && !products.empty? &&
        products.all? { |item| item.is_a?(Product) && item.valid? }
    end
  end
end
