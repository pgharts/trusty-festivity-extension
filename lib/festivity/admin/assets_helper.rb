module Festivity
  module Admin
    module AssetsHelper

      def page_image_url(title)
        image = assets.find_by_title(title) if assets.size > 0
        image.thumbnail(:normal) unless image.nil?
      end

      def page_image_url_from_all_assets title
        image = Asset.find_by_title(title)
        image.thumbnail(:normal) unless image.blank?
      end

    end
  end
end