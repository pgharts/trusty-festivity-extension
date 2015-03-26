class FestivityEventList::FestivityLocation

  attr_reader :id, :title, :slug, :area_id, :area_title, :area_slug, :directions_url

  def initialize(location_hash)
    @id = location_hash[:id]
    @title = location_hash[:title]
    @slug = location_hash[:slug]
    @directions_url = location_hash[:directions_url]
    @area_id = location_hash[:area_id]
    @area_title = location_hash[:area_title]
    @area_slug = location_hash[:area_slug]
  end

end