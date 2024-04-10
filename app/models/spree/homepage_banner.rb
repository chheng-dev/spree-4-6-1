module Spree
  class HomepageBanner < Spree::Base 
    acts_as_paranoid
    acts_as_list column: :priority

    validates_associated :image
    has_one_attached :image


    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::HomepageBannerImage'
  end
end
