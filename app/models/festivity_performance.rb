class FestivityPerformance < ActiveRecord::Base
  validates_presence_of :event_page_id
  belongs_to :festivity_event_page, foreign_key: :event_page_id
  belongs_to :festivity_location_page, foreign_key: :location_page_id

  def start_date=(date)
    super(parse_date(date))
  end

  def end_date=(date)
    super(parse_date(date))
  end

  private

  def parse_date(date)
    DateTime.strptime(date, '%m/%d/%Y %H:%M %p')
  rescue
    nil
  end

end