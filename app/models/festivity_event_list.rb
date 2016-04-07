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

  def self.find_by_location(location_id, site)
    begin
      where_clause = parse_criteria(dates: collect_festival_dates(site).join(","), filter_type: site.festivity_filter_type)
    rescue ActiveRecord::RecordNotFound
      return FestivityEventList.new([])
    end

    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where(where_clause).
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

  def self.collect_festival_dates(site)
    festival_dates = site.festival_datetimes
    if site.date_during_festival?(Time.now)
      festival_dates = festival_dates.select{ |date| date.datetime == Time.now }
    end

    festival_dates.map{ |date| date.to_s }

  end

  private

  # Return a list of unique event ids that match the provided dates
  def self.event_ids_for_datetimes(datetimes, filter_type)
    FestivityEventList::FestivityEventPerformance.where(datetime_criteria(datetimes, filter_type)).map {|e| e.event_id}.uniq
  end

  # Create a condition for start and end date between midnight and 11:59pm
  # for each date passed in and return the SQL condition
  def self.datetime_criteria(datetimes_string, filter_type)

    date_queries = datetimes_string.split(',').map do |date_string|
      start_date = Chronic.parse(URI.decode(date_string)).utc
      end_date = start_date.advance(advance_by(filter_type))
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
    if criteria[:dates]
      # related events fails if filter_type is nil - this is a fallback for nil filter_type
      site_filter = Site.find_by_id(Page.current_site.id).festivity_filter_type
      filter = criteria[:filter_type] ||= site_filter
      event_ids = event_ids_for_datetimes(criteria[:dates], filter)
      raise ActiveRecord::RecordNotFound unless event_ids.any?
    end

    where_clause = "site_id = #{ Page.current_site.id}"
    where_clause += " AND event_id IN (#{event_ids.join(",")})" if event_ids.present?
    where_clause += " AND #{parse_categories(criteria[:categories].split(","))}" if criteria[:categories]
    where_clause
  end


end

