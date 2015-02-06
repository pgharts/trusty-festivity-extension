module Festivity
  module Extensions
    module SiteExtensions

      def self.included(base)
        base.class_eval {
          has_many :festivity_category_types
        }

      end

    end
  end
end