class FestivityEventList

  attr_reader :events

  def initialize(event_performances)
    @events = event_performances.group_by {|perf| perf.event_id }.
        map { |perfs| FestivityEventList::FestivityEvent.new(perfs[0], perfs[1]) }

  end

  def self.search(criteria, order_by)
    where_clause = parse_criteria(criteria)
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
  def self.event_ids_for_dates(dates)
    FestivityEventList::FestivityEventPerformance.where(date_criteria(dates)).map {|e| e.event_id}.uniq
  end

  # Create a condition for start and end date between midnight and 11:59pm
  # for each date passed in and return the SQL condition
  def self.date_criteria(dates_string)
    date_queries = dates_string.split(',').map do |date_string|
      start_date = DateTime.parse(date_string)
      end_date = start_date.advance(hours: 23, minutes: 59)
      <<-SQL
        (
          (start_date >= '#{start_date}' AND start_date <= '#{end_date}')
          OR
          (end_date >= '#{start_date}' AND end_date <= '#{end_date}')
        )
      SQL
    end
    date_queries.join(" OR ")
  end

  # The order of querying, depending on what is passed:
  # - If dates are passed, we search both start and end date between midnight and 11:59pm of that date.
  #   That query returns any matching event ids.
  # - The event ids returned, if any, are added to the where clause for the next query
  # - Any category ids passed are added to the where clause as well.
  def self.parse_criteria(criteria)
    where_clause = {}
    event_ids = event_ids_for_dates(criteria[:dates]) if criteria[:dates]
    where_clause["site_id"] = Page.current_site.id
    where_clause["event_id"] = event_ids if event_ids
    where_clause["festivity_categories.id"] = criteria[:categories].split(",") if criteria[:categories]
    where_clause
  end


end