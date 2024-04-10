mount Spree::Core::Engine, at: '/'
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# https://github.com/sidekiq/sidekiq/issues/4846
# Sidekiq::Web.set :sessions, false

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
end if ENV['SIDEKIQ_USERNAME'].present? && ENV['SIDEKIQ_PASSWORD'].present?

mount Sidekiq::Web => '/queued/admin'

authenticate :spree_user, ->(user) { user.admin? } do
  mount Searchjoy::Engine, at: "admin/search_reports"
  mount Blazer::Engine, at: "admin/bi_reports"
end
