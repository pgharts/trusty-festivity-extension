class Admin::FestivityCategoryTypesController  < Admin::ResourceController

  def index

  end

  def create
    site = Site.find(params[:site_id])

    if site.festivity_category_types.new(name: params[:name], page_class: params[:page_class]).save
      render partial: 'admin/sites/partials/category_types', :locals => { :category_types => site.festivity_active_category_types}
    else
      render head: :bad_request
    end

  end

end