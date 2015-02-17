class Admin::FestivityCategoryTypesController  < Admin::ResourceController

  def index

  end

  def show

  end

  def create
    site = Site.find(params[:site_id])

    if site.festivity_category_types.new(name: params[:name], page_class: params[:page_class]).save
      render partial: 'admin/sites/partials/category_types', :locals => { :category_types => site.festivity_active_category_types}
    else
      render status: :conflict, text: "Category Type name must be unique."
    end

  end

  def destroy
    category_type = FestivityCategoryType.find(params[:id])
    site = Site.find(category_type.site_id)
    category_type.inactive = true
    if category_type.save!
      render partial: 'admin/sites/partials/category_types', :locals => { :category_types => site.festivity_active_category_types}
    end
  end

end