class FestivityEventList::FestivityEventPerformance < ActiveRecord::Base
  self.table_name = 'festivity_event_performances'
  after_initialize :readonly!

  has_many :festivity_page_categories, foreign_key: :page_id, primary_key: :event_id
  has_many :festivity_categories, through: :festivity_page_categories
  has_many :page_attachments, primary_key: :event_id, foreign_key: :page_id
  has_many :assets, through: :page_attachments

end