class Admin::FestivityCategoriesController  < Admin::ResourceController

  def index

  end

  def show

  end

  def create
    category_type = FestivityCategoryType.find(params[:category_type_id])

    if category_type.festivity_categories.new(name: params[:name], parent_id: params[:parent_id]).save
      render partial: 'admin/sites/partials/filters', :locals => { :category_types => category_type.site.festivity_active_category_types}
    else
      render status: :conflict, text: "#{category_type.name} must be unique."
    end

  end

  def destroy
    category = FestivityCategory.find(params[:id])
    site = Site.find(category.festivity_category_type.site_id)
    category.inactive = true
    if category.save!
      render partial: 'admin/sites/partials/filters', :locals => { :category_types => site.festivity_active_category_types}
    end
  end

end