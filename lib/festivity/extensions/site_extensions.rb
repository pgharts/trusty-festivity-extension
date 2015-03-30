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

        def festival_dates
          @festival_dates ||= calculate_festival_dates
        end

        def calculate_festival_dates
          dates = [self.festivity_start_date]
          until dates.last >= self.festivity_end_date do
            dates << dates.last.advance(days: 1)
          end
          dates
        end

      end

    end
  end
end