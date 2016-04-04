module Concerns
  module FestivityCustomPage

    extend ActiveSupport::Concern

    included do
      include Festivity::Mixins::NotFound
      no_login_required
      trusty_layout 'base'
    end
  end
end