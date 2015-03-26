class FestivityEventList::FestivityEvent
  include Festivity::Admin::AssetsHelper

  attr_reader :id, :performances, :locations, :categories, :title, :short_description,
              :assets, :header, :sub_header, :featured_item, :buy_url

  def initialize(event_id, performances)
    @id = event_id
    @performances = performances
    @title = performances.first.event_title
    @short_description = performances.first.short_description
    @header = performances.first.header
    @sub_header = performances.first.sub_header
    @featured_item = performances.first.featured_item
    @buy_url = performances.first.buy_url

    @locations = self.performances.
        map{ |performance| FestivityEventList::FestivityLocation.new ({
        id: performance.location_id,
        slug: performance.location_slug,
        title: performance.location_title,
        directions_url: performance.festivity_directions_url,
        area_id: performance.area_id,
        area_slug: performance.area_slug,
        area_title: performance.area_title}) }.
        uniq{ |location| location.id }

    @categories = performances.first.festivity_categories

    @assets = performances.first.assets

  end

  def image
    image = assets.select { |asset| asset.title == "featured_image" }.first if assets.size > 0
    image.thumbnail(:normal) unless image.nil?
  end


end