module Concerns
  module FestivitySearchCaching

    extend ActiveSupport::Concern

    included do
      caches_action :index, cache_path: proc { |c| c.params.except(:_).merge(format: request.xhr?, base_domain: "#{request.subdomain}.#{request.domain}")}
      caches_action :show
    end
  end
end