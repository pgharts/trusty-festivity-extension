class FestivityCategory < ActiveRecord::Base
  acts_as_list :scope => :parent_id
  belongs_to :festivity_category_type
  has_many :pages, through: :festivity_page_categories
  #self.reflections[:children].options[:position] = "position ASC"

  attr_accessible :name, :festivity_category_type_id, :parent_id, :position, :inactive

  def parent
    FestivityCategory.find(self.parent_id)
  end

  def children
    FestivityCategory.where(parent_id: self.id, inactive: false)
  end

end