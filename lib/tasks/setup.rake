namespace :festivity do
  namespace :setup do
    require File.dirname(__FILE__) + '/active_record_util'

    desc "bootstrap deployment. Creates DB, migrate db, migrate the extensions, and seed"
    task :bootstrap => [:environment, 'db:drop', 'db:create', 'db:migrate', 'db:migrate:extensions', 'increment:create_or_update']

    desc "seed festivity sites and pages"
    task :seed do

      sites = sort(load_yaml_for("sites"), "position")
      home_pages = load_yaml_for("home_pages")
      pages = load_yaml_for("pages")

      # create the root page
      master = home_pages["The Pittsburgh Cultural Trust"]
      create_or_update_page(master)

      sites.each do |t, site|
        home_page = home_pages[site["name"]]
        seed_page_for(home_page, master["slug"])
        site['homepage'] = site["name"] == 'default_site' ? Page.find(1) : find_by_slug_hierarchy([home_page["slug"]])
        site['base_domain'] += Rails.configuration.domain
        Site.create_or_update(site, :organization_id)

        pages.each do |p_t, page|
          seed_page_for(page, home_page["slug"])
        end

      end
      #for each site
        #seed site
        #seed homepage
        #seed site-specific pages under homepage
    end


    def seed_page_for(page_hash, home_page_slug = nil)
      trusty_page = create_or_update_page(page_hash, home_page_slug)
      part = PagePart.new(:name => 'body')
      trusty_page.parts << part unless trusty_page.parts.find_by_name('body')
      trusty_page.save!
    end

    def seed_home_page_for(site)
      home_pages = load_yaml_for("home_pages")
      home_pages.each do |t, home_page|

      end
    end

    def load_yaml_for(file_name)
      require 'yaml'
      fixtures_dir = "#{File.expand_path(File.dirname(__FILE__)+"../../../db/fixtures")}"
      YAML::load(File.open(File.join(fixtures_dir, file_name+".yml")))
    end

    def load_content_from(dir, file_name)
      content_dir = "#{File.expand_path(File.dirname(__FILE__)+"../../../db/content")}"

      file_path = content_dir + "/#{dir}/" + "#{file_name}.html"
      puts "Seed:Log: found layout for #{file_name} in #{dir}"
      File.open(file_path, 'r').read
    end

    def create_or_update_page(page_hash, home_page_slug = nil)
      if page_hash["parent"]
        parent_path = home_page_slug ? home_page_slug : []
        parent_path << page_hash["parent"].split('/')
        page_hash["parent"] = find_by_slug_hierarchy(parent_path)
      end

      page = (page_hash["parent"].nil? ? find_by_slug_hierarchy([page_hash["slug"]]) : find_by_slug_hierarchy([page_hash["slug"]], page_hash["parent"])) || Page.new
      page.create_or_update_with_attributes!(page_hash)
      page
    end

  end
end
