class FestivityEventsController < ApplicationController
  no_login_required
  trusty_layout 'normal'

  def index
    @events = FestivityEventList.search({}).events
  end

  def show
    @event = FestivityEventPage.find_by_slug_and_status_id(params[:id], Status[:published].id)

  end

end