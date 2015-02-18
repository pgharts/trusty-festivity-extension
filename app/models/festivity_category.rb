class FestivityCategory < ActiveRecord::Base
  acts_as_list :scope => :parent_id
  belongs_to :festivity_category_type
  #self.reflections[:children].options[:position] = "position ASC"

  def parent
    FestivityCategory.find(self.parent_id)
  end

  def children
    FestivityCategory.where(parent_id: self.id, inactive: false)
  end

end