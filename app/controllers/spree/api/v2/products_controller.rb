module Spree
  module Api
    module V2
      class ProductsController < Spree::Api::V2::BaseController
        def index 
          products = Spree::Product.all
          render json: { data: products }
        end
      end
    end
  end
end
