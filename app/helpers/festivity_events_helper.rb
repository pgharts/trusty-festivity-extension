module FestivityEventsHelper
  include RadSocialHelper

  def date_time_popover(performances)
    "<div><ul class='list-unstyled'>#{date_time_list_items(performances)}</ul></div>"
  end

  def date_time_list_items(performances)
    performances.map {|perf| "<li>#{perf.start_date.strftime('%a, %B %d')}, #{perf.start_date.strftime('%I:%M%p').downcase} - #{perf.end_date.strftime('%I:%M%p').downcase}</li>" }.join("")
  end

end