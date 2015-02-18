class FestivityCategoryType < ActiveRecord::Base
  acts_as_list scope: :site_id
  has_many :festivity_categories
  belongs_to :site
  validates_uniqueness_of :name, scope: :site_id


  def parent_categories
    self.festivity_categories.where(inactive: false, parent_id: nil)
  end

end