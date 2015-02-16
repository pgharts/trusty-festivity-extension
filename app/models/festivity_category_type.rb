class FestivityCategoryType < ActiveRecord::Base
  acts_as_list scope: :site_id
  has_many :festivity_categories
  validates_uniqueness_of :name, scope: :site_id
end