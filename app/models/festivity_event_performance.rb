class FestivityEventPerformance < ActiveRecord::Base
  self.table_name = 'festivity_event_performances'
  after_initialize :readonly!

  has_many :festivity_categories, through: :festivity_page_categories, foreign_key: :event_id, primary_key: :event_id

end