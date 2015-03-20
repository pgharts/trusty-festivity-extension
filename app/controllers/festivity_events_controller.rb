class FestivityEventsController < ApplicationController
  no_login_required
  trusty_layout 'normal'

  def index

  end

  def show
    @event = FestivityEventPage.find_by_slug_and_status_id(params[:id], Status[:published].id)

  end

end