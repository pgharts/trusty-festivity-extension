class FestivityEventList::FestivityLocation

  attr_reader :id, :title, :area_id, :area_title

  def initialize(location_hash)
    @id = location_hash[:id]
    @title = location_hash[:title]
    @area_id = location_hash[:area_id]
    @area_title = location_hash[:area_title]
  end

end