class CreateSpreeHomepageBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_homepage_banners do |t|
      t.string :title 
      t.string :image 
      t.boolean :active, default: true 
      t.integer   :priority
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
