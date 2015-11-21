class FestivityPerformance < ActiveRecord::Base
  validates_presence_of :event_page_id
  belongs_to :festivity_event_page, foreign_key: :event_page_id
  belongs_to :festivity_location_page, foreign_key: :location_page_id
  default_scope {order :start_date}

  attr_accessible :start_date, :end_date, :festivity_location_page, :notes

  def start_date=(date)
    super(parse_date(date))
  end

  def end_date=(date)
    super(parse_date(date))
  end

  def festivity_location_page=(location)
    super(FestivityLocationPage.find(location[:id])) unless location[:id].blank?
  end

  private

  def parse_date(date)
    Chronic.parse(date)
  rescue
    nil
  end

end