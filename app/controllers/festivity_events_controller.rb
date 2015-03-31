class FestivityEventsController < ApplicationController
  no_login_required
  trusty_layout 'base'

  def index
    @events = FestivityEventList.search({}).events

    # If the request is AJAX, only return the event list itself, not the full page
    if request.xhr?
      render partial: "event_list"
    else
      render 'index'
    end

  end

  def show
    @event = FestivityEventPage.find_by_slug_and_status_id(params[:id], Status[:published].id)
  end

end