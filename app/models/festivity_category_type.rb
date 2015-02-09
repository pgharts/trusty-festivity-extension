class FestivityCategoryType < ActiveRecord::Base
  acts_as_list :scope => :site_id
end