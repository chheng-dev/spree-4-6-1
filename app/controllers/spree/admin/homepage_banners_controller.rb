module Spree
  module Admin
    class HomepageBannersController < ResourceController
      def create 
        if permitted_resource_params[:image]
          @homepage_banner.build_image(attachment: permitted_resource_params.delete(:image))
        end
        super
      end

      def update
        if permitted_resource_params[:image]
          @homepage_banner.create_image(attachment: permitted_resource_params.delete(:image))
        end
        super
      end

      private 

      def find_resource 
        HomepageBanner.with_deleted.find(params[:id])
      end

      def collection 
        params[:q] = {}  if params[:q].blank?
        homepage_banners = super.order(priority: :asc)
        @search = homepage_banners.ransack(params[:q])

        @collection = @search.result.
                      page(params[:page]).
                      per(params[:per_page])
      end

    end 
  end
end