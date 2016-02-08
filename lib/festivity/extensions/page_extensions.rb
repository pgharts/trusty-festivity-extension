module Festivity
  module Extensions
    module PageExtensions

      def self.included(base)
        base.class_eval {

          before_save :set_page_defaults
          after_create  :create_page_defaults

          has_many :festivity_category_types
          has_many :festivity_page_categories
          has_many :festivity_categories, through: :festivity_page_categories

          include ActsAsTree::InstanceMethods
          include Festivity::Extensions::PageExtensions::PageMethods
          include Festivity::Admin::AssetsHelper

          alias_method_chain :find_by_path, :vanity_urls
        }

      end

      module PageMethods

        def create_page_defaults
          self.save if festivity_base_page?
        end

        def set_page_defaults
          if festivity_base_page? && self.id
            self.slug = self.id unless self.slug == self.id
            parts.create(:name => 'video_embed', :content => "") unless parts.any? { |part| part.name == 'video_embed' }
            parts.create(:name => 'sponsor_logo', :content => "") unless parts.any? { |part| part.name == 'sponsor_logo' }
          end
        end

        def image
          page_image_url('featured_image')
        end

        def organization
          page_organization = nil
          page_parent = self.parent
          while page_organization == nil
            page_organization = page_parent.site
            page_parent = page_parent.parent
          end
          page_organization
        end

        def find_by_path_with_vanity_urls(path, live = true, clean = true)
          raise MissingRootPageError unless root
          page = self.find_by_path_without_vanity_urls(path, live, clean)
          if page.is_a?(FileNotFoundPage)
            vanity_url = VanityUrlPage.find_vanity_url_by_path(path, live)
          end
          vanity_url ? vanity_url : page
        end

        private

        def festivity_base_page?
          (self.class_name == "FestivityEventPage") | (self.class_name == "FestivityMarketPage")
        end

      end

    end
  end
end

