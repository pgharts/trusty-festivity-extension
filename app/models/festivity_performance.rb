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

  def festivity_location_page=(location)
    super(FestivityLocationPage.find(location[:id])) unless location[:id].blank?
  end

  private

  def parse_date(date)
    Time.strptime("#{date} #{Time.zone.now.formatted_offset(false)}", '%m/%d/%Y %I:%M %p %Z')
  rescue
    nil
  end

end