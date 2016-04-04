class FestivityMarketList::FestivityMarketDetail < ActiveRecord::Base
  self.table_name = 'festivity_market_details'
  after_initialize :readonly!

  has_many :festivity_page_categories, foreign_key: :page_id, primary_key: :market_id
  has_many :festivity_categories, through: :festivity_page_categories
  has_many :page_attachments, primary_key: :market_id, foreign_key: :page_id
  has_many :assets, through: :page_attachments


  def id
    market_id
  end

  def categories
    festivity_categories
  end

  def image
    image = assets.select { |asset| asset.title == "featured_image" }.first if assets.size > 0
    image.thumbnail(:normal) unless image.nil?
  end

end