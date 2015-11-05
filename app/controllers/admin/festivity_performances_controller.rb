class Admin::FestivityPerformancesController  < Admin::ResourceController
  def create
    event = FestivityEventPage.find(params[:event_page_id])
    performance = event.festivity_performances.new
    if performance.save
      render partial: 'admin/pages/partials/performance', :locals => {:performance => performance, :locations => FestivityLocationPage.where(site_id: event.site.id) }
    else
      render status: :bad_request
    end

  end

  def destroy
    performance = FestivityPerformance.find(params[:id])
    page_id = performance.festivity_event_page.id
    if performance.destroy
      render partial: 'admin/pages/partials/performances_table', :locals => { :performances => FestivityEventPage.find(page_id).festivity_performances, :page_id => page_id, locations: FestivityLocationPage.all}
    end
  end

end