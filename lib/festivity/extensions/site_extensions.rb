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

        def festivity_start_date=(value)
          super(Chronic.parse(value))
        end

        def festivity_end_date=(value)
          super(Chronic.parse(value))
        end

        def festivity_active_category_types
          self.festivity_category_types.where(["inactive = false"])
        end

        def date_during_festival?(date)
          self.festival_datetimes.any? {|festival_date| festival_date.datetime == date}
        end

        def festival_datetimes
          @festival_datetimes ||= calculate_festival_datetimes
        end

        def calculate_festival_datetimes
          dates = [self.festivity_start_date]
          advance_by = date_filter? ? {days: 1} : {hours: 1}
          until dates.last >= self.festivity_end_date do
            dates << dates.last.advance(advance_by)
          end
          FestivityDatetimeFilterPresenter.new(dates, self.festivity_filter_type)
        rescue
          []
        end

        def date_filter?
          self.festivity_filter_type == "date"
        end

      end

    end
  end
end