class FestivityEventPage < FestivityBasePage
  has_many :festivity_performances, foreign_key: :event_page_id
end