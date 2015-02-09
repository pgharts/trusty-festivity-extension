module Festivity
  module Extensions
    module SiteExtensions

      def self.included(base)
        base.class_eval {
          has_many :festivity_category_types
          include Festivity::Extensions::SiteExtensions::SiteMethods
        }
      end

      module SiteMethods

        def festivity_active_category_types
          self.festivity_category_types.where(["inactive = false"])
        end

      end

    end
  end
end