class FestivityPageCategory < ActiveRecord::Base
  belongs_to :festivity_category
  belongs_to :page
end