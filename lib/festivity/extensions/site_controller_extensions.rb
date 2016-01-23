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
          redirect_to page.clean_target_url
          false
        elsif !page.redirect_url.nil? && !page.redirect_url.empty?
          redirect_to page.redirect_url
          false
        else
          process_page_without_redirection(page)
        end
      end


    end
  end
end

