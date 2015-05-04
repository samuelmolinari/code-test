module MAndS
  ##
  # Catalog error raised when the catalog is invalid
  class ProductsError < Exception
    def initialize
      super('List of products  must be an array of minimum size 1,
            only containing products')
    end
  end
end
