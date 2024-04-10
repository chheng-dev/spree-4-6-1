module Spree
  module Api
    module V2
      class HomepageBannersController < Spree::Api::V2::BaseController
        def index 
          homepage_banners = Spree::HomepageBanner.includes(:image).all
          rendered_banners = homepage_banners.map do |banner|
            {
              id: banner.id,
              title: banner.title,
              image: main_app.url_for(banner.image.url(:large)),
              active: banner.active,
              priority: banner.priority,
              deleted_at: banner.deleted_at,
              created_at: banner.created_at,
              updated_at: banner.updated_at
            }
          end
        
          render json: { homepage_banners: rendered_banners }
        end
      end
    end
  end
end
