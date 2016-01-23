class VanityUrlPage < Page

  def clean_target_url
    (self.target_url.match('http://') || self.target_url.match('https://')) ? self.target_url : VanityUrlPage.clean_path(self.target_url)
  end

  class << self

    def find_vanity_url_by_path(path, live = true)
      vanity_url_page = Page.current_site.homepage.children.find_by_slug('vanity-urls')
      vanity_pages = vanity_url_page.children.where("vanity_url like '%#{path}%'")
      vanity_pages.each do |vanity_page|
        return vanity_page if clean_comparison_path(path).downcase == clean_comparison_path(vanity_page.vanity_url).downcase
      end
      nil
    end

    def clean_comparison_path(path)
      "#{clean_path(path)}/"
    end

    def clean_path(path)
      "/#{path.to_s.strip}".gsub(%r{//+}, '/')
    end

  end

end
