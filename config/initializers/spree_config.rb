Spree::Config.class_eval do
  preference :user_default_vendor_id, :integer ## for merhant app testing purpose
  preference :user_default_spree_role_id, :integer ## for merhant app testing purpose
  preference :admin_vendor_logo, :boolean, default: true
  preference :override_vendor_user_ability_to_create_order, :boolean, default: false
  preference :store_category_taxonnomy_id, :integer
  preference :homepage_displayed_product_taxon_ids, :array, default: []
  preference :top_category_taxon_ids, :array, default: []
  preference :trending_category_taxon_ids, :array, default: []
  preference :featured_brand_taxon_ids, :array, default: []
  preference :featured_vendor_ids, :array, default: []
  preference :menu_trending_taxon_ids, :array, default: []
  preference :default_tg_bot, :string, default: ''
  preference :tg_alert_group_id, :string, default: ''

  ## Old data with array value is use with comma separated
  def array_patch_value(value)
    return [] if value.blank?
    return value.split(',').reject(&:blank?) if value.instance_of?(String)

    value.reject(&:blank?)
  end

  def array_patch(key)
    array_patch_value(self[key])
  end

  Spree::PermittedAttributes.address_attributes << :lat # 11.57782597
  Spree::PermittedAttributes.address_attributes << :lon # 104.90603155
  Spree::PermittedAttributes.address_attributes << :commune
  Spree::PermittedAttributes.address_attributes << :address_type # home
  Spree::PermittedAttributes.address_attributes.concat(%i[street_number house_number commune])

  Spree::PermittedAttributes.checkout_attributes << :phone_number

  Spree::PermittedAttributes.user_attributes << :phone_number
  Spree::PermittedAttributes.user_attributes << :is_creator
  Spree::PermittedAttributes.user_attributes << :ship_address_id
  Spree::PermittedAttributes.user_attributes << :is_vendor
  Spree::PermittedAttributes.user_attributes << :staff_id_number
  Spree::PermittedAttributes.user_attributes << :organization_id
  Spree::PermittedAttributes.user_attributes << :efa
end
