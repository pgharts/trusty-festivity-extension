class FestivityEventList::FestivityEvent

  attr_reader :id, :performances, :locations, :categories

  def initialize(event_id, performances)
    @id = event_id
    @performances = performances

    @locations = self.performances.
        map{ |performance| FestivityEventList::FestivityLocation.new ({
        id: performance.location_id,
        title: performance.location_title,
        area_id: performance.area_id,
        area_title: performance.area_title}) }.
        uniq{ |location| location.id }

    @categories = performances.first.festivity_categories

  end


end