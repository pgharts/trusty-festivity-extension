class FestivityEventPage < FestivityBasePage
  has_many :festivity_performances, foreign_key: :event_page_id

  def festivity_performances=(performances)
    performances.each do |performance|
      performance_id = performance.delete(:performance_id)
      FestivityPerformance.find(performance_id).update_attributes(performance)
    end
  end

  def locations
    @locations ||= event_locations
  end


  private

  def event_locations
    # Return array of unique locations
    self.festivity_performances.
        map{ |performance| performance.festivity_location_page }.
        uniq{ |location| location.id }
  end


end