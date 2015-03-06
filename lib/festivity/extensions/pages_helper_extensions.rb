module Festivity::Extensions::PagesHelperExtensions

  def self.included(base)
    base.class_eval do
      def format_date(date)
        date.strftime('%m/%d/%Y %H:%M %p') if date
      end
    end
  end

  module HelperMethods

  end

end
