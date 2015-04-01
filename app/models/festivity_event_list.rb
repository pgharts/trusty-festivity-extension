class FestivityEventList

  attr_reader :events

  def initialize(event_performances)

    @events = event_performances.group_by {|perf| perf.event_id }.
        map { |perfs| FestivityEventList::FestivityEvent.new(perfs[0], perfs[1]) }

  end

  def self.search(criteria, order_by = "start_date")
    # find events WHERE site_id = current site
    # JOIN Page Categories; Where category_id in [list]
    # JOIN Performances on event_id
    FestivityEventList.new(
        FestivityEventList::FestivityEventPerformance.
            includes(:assets).
            joins(:festivity_categories).
            where("festivity_categories.id" => [1]).
            preload(:festivity_categories)
    )
  end

  private

  def parse_criteria(criteria)

  end


end