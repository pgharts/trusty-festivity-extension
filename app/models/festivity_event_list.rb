class FestivityEventList

  include Concerns::FestivitySqlBuilder

  attr_reader :events

  def initialize(event_performances)
    @events = event_performances.group_by {|perf| perf.event_id }.
        map { |perfs| FestivityEventList::FestivityEvent.new(perfs[0], perfs[1]) }

  end

  def self.search(criteria, order_by)
    begin
    where_clause = parse_criteria(criteria)
    rescue ActiveRecord::RecordNotFound
      return FestivityEventList.new([])
    end

    # where in event ids
    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where(where_clause).
            group("performance_id").
            order("featured_item DESC, #{order_by} ASC").
            preload(:festivity_categories)
    )
  end

  def self.find_by_location(location_id)
    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where(location_id: location_id).
            group("performance_id").
            order("featured_item DESC, start_date ASC").
            preload(:festivity_categories)
    )
  end

  def self.find_related_events(criteria)
    where_clause = parse_criteria(criteria)
    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where(where_clause).
            where("event_id != ?", criteria[:event_id]).
            group("performance_id").
            order("featured_item DESC, start_date ASC").
            preload(:festivity_categories)
    )
  end

  private

  # Return a list of unique event ids that match the provided dates
  def self.event_ids_for_datetimes(datetimes, filter_type)
    FestivityEventList::FestivityEventPerformance.where(datetime_criteria(datetimes, filter_type)).map {|e| e.event_id}.uniq
  end


  # The order of querying, depending on what is passed:
  # - If dates are passed, we search both start and end date between midnight and 11:59pm of that date.
  #   That query returns any matching event ids.
  # - The event ids returned, if any, are added to the where clause for the next query
  # - Any category ids passed are added to the where clause as well.
  def self.parse_criteria(criteria)
    if criteria[:dates]
      event_ids = event_ids_for_datetimes(criteria[:dates], criteria[:filter_type])
      raise ActiveRecord::RecordNotFound unless event_ids.any?
    end

    where_clause = "site_id = #{ Page.current_site.id}"
    where_clause += " AND event_id IN (#{event_ids.join(",")})" if event_ids.present?
    where_clause += " AND #{parse_categories(criteria[:categories].split(","))}" if criteria[:categories]
    where_clause
  end


end

