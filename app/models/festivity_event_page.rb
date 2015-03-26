class FestivityEventPage < FestivityBasePage
  has_many :festivity_performances, foreign_key: :event_page_id

  def festivity_performances=(performances)
    performances.each do |performance|
      performance_id = performance.delete(:performance_id)
      FestivityPerformance.find(performance_id).update_attributes(performance)
    end
  end

  def performances
    self.festivity_performances.select {|perf| perf.festivity_location_page && perf.start_date && perf.end_date }
  end

  def single_location?
    @single_location ||= self.locations.count == 1
  end

  def locations
    @locations ||= event_locations
  end

  def can_buy?
    !self.buy_url.empty?
  end

  def has_social?
    (has_twitter? or has_facebook? or has_homepage? or has_instagram?)
  end

  def has_twitter?
    !self.artist_twitter.empty?
  end

  def has_facebook?
    !self.artist_facebook.empty?
  end

  def has_instagram?
    !self.artist_instagram.empty?
  end

  def has_homepage?
    !self.artist_facebook.empty?
  end

  def event_locations
    # Return array of unique locations
    self.performances.
        map{ |performance| performance.festivity_location_page }.
        uniq{ |location| location.id }
  end


end