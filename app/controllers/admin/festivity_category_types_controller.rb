class Admin::FestivityCategoryTypesController  < Admin::ResourceController

  def index

  end

  def create

    # get site
    # add category
    # save

    render partial: 'category_types', :category_types => @category_types

  end

end