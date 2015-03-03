class FestivityPerformance < ActiveRecord::Base
  validates_presence_of :event_page_id
  belongs_to :festivity_event_page, foreign_key: :event_page_id
  belongs_to :festivity_location_page, foreign_key: :location_page_id

end