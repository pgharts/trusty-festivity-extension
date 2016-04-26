module FestivityEventsHelper
  include RadSocialHelper

  def date_time_popover(performances)
    "<div><ul class='list-unstyled'>#{date_time_list_items(performances)}</ul></div>"
  end

  def date_time_list_items(performances)
    performances.map {|perf| "<li>#{perf.start_date.strftime('%A, %B %d')}, #{perf.start_date.strftime('%I:%M %p').downcase} - #{perf.end_date.strftime('%I:%M %p').downcase}</li>" }.join("")
  end

  def social_share_message(production)
    "Check out #{production.title} for #{fest_hashtag} @ #{production.locations.first.title}!"
  end

  def social_share_email_subject(production)
    "Check out #{production.title}"
  end

  def social_share_email_message(production)
    "I thought you might be interested in seeing #{production.title}."
  end

  def shared_production_url
    "#{event_url}?cid=CDSocial"
  end

  def fest_hashtag
    current_site.social_media_tag
  end

end
