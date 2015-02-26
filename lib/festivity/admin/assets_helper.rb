module Festivity
  module Admin
    module AssetsHelper

      def image_url(title)
        image = assets.find_by_title(title) if assets.size > 0
        image.thumbnail(:original) unless image.nil?
      end

      def image_url_from_all_assets title
        image = Asset.find_by_title(title)
        image.thumbnail(:original) unless image.blank?
      end

    end
  end
end