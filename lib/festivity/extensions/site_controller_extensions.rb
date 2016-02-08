module Festivity
  module Extensions
    module SiteControllerExtensions

      def self.included(base)
        base.class_eval do
          alias_method_chain :process_page, :redirection
        end
      end


      def process_page_with_redirection(page)
        if page.is_a?(VanityUrlPage)
          false if redirect_to page.clean_target_url

        elsif !page.redirect_url.nil? && !page.redirect_url.empty?
          false if redirect_to page.redirect_url
        else
          process_page_without_redirection(page)
        end
      end


    end
  end
end

