class FestivityEventPage < FestivityBasePage
  has_many :festivity_performances, foreign_key: :event_page_id

  def festivity_performances=(performances)
    performances.each do |performance|
      performance_id = performance.delete(:performance_id)
      FestivityPerformance.find(performance_id).update_attributes(performance)
    end

  end

end