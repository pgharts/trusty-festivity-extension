class Admin::FestivityPerformancesController  < Admin::ResourceController

  def create
    event = FestivityEventPage.find(params[:event_page_id])
    performance = event.festivity_performances.new
    if performance.save
      render partial: 'admin/pages/partials/performance', :locals => { :performance => performance }
    else
      render status: :bad_request
    end

  end

  def destroy
    performance = FestivityPerformance.find(params[:id])
    if performance.destroy
      render status: :ok
    end
  end

end