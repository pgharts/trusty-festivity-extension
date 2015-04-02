class FestivityEventList

  attr_reader :events

  def initialize(event_performances)
    @events = event_performances.group_by {|perf| perf.event_id }.
        map { |perfs| FestivityEventList::FestivityEvent.new(perfs[0], perfs[1]) }

  end

  def self.search(criteria, order_by = "start_date")
    where_clause = parse_criteria(criteria)
    # where in event ids
    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where(where_clause).
            group("performance_id").
            preload(:festivity_categories)
    )
  end

  private

  # Return a list of unique event ids that match the provided dates
  def self.event_ids_for_dates(dates)
    FestivityEventList::FestivityEventPerformance.where(date_criteria(dates)).map {|e| e.event_id}.uniq
  end

  def self.date_criteria(dates_string)
    date_queries = dates_string.split(',').map do |date_string|
      start_date = DateTime.parse(dates_string)
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

  def self.parse_criteria(criteria)
    where_clause = {}
    event_ids = event_ids_for_dates(criteria[:dates]) if criteria[:dates]
    where_clause["event_id"] = event_ids if event_ids
    where_clause["festivity_categories.id"] = criteria[:categories].split(",") if criteria[:categories]
    where_clause
  end


end