class FestivityMarketList

  include Concerns::FestivitySqlBuilder

  attr_reader :markets


  def initialize(market_details)
    @markets = market_details
  end

  def self.search(criteria)
    begin
      where_clause = parse_criteria(criteria)
    rescue ActiveRecord::RecordNotFound
      return FestivityMarketList.new([])
    end

    # where in event ids
    FestivityMarketList.new(
      FestivityMarketList::FestivityMarketDetail.
        includes(:assets).
        joins(:festivity_categories).
        where(where_clause).
        order("start_date ASC").
        preload(:festivity_categories)
    )
  end


  private


  # Return a list of unique event ids that match the provided dates
  def self.market_ids_for_datetimes(datetimes, filter_type)
    FestivityEventList::FestivityMarketDetail.where(datetime_criteria(datetimes, filter_type)).map {|e| e.market_id}.uniq
  end


  # The order of querying, depending on what is passed:
  # - If dates are passed, we search both start and end date between midnight and 11:59pm of that date.
  #   That query returns any matching market ids.
  # - The market ids returned, if any, are added to the where clause for the next query
  # - Any category ids passed are added to the where clause as well.

  def self.parse_criteria(criteria)
    if criteria[:dates]
      market_ids = market_ids_for_datetimes(criteria[:dates], criteria[:filter_type])
      raise ActiveRecord::RecordNotFound unless market_ids.any?
    end

    where_clause = "site_id = #{ Page.current_site.id}"
    where_clause += " AND event_id IN (#{market_ids.join(",")})" if market_ids.present?
    where_clause += " AND #{parse_categories(criteria[:categories].split(","))}" if criteria[:categories]
    where_clause
  end

end