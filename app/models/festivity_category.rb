class FestivityCategory < ActiveRecord::Base
  acts_as_list :scope => :parent_id
  self.reflections[:children].options[:order] = "position ASC"
end