module Festivity
  module Extensions
    module PageExtensions

      def self.included(base)
        base.class_eval {
          has_many :festivity_category_types
          has_many :festivity_page_categories
          has_many :festivity_categories, through: :festivity_page_categories
          include Festivity::Extensions::PageExtensions::PageMethods
        }
      end

      module PageMethods

        def organization
          page_organization = nil
          page_parent = self.parent
          while page_organization == nil
            page_organization = page_parent.site
            page_parent = page_parent.parent
          end
          page_organization
        end

      end

    end
  end
end

