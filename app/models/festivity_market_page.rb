class FestivityMarketPage < FestivityBasePage

  include Concerns::FestivityArtistMethods
  has_many :festivity_categories, through: :festivity_page_categories

  def area
    FestivityLocationAreaPage.find(area_id)
  end

  def self.booth_number(market_id)
    self.find_by_id(market_id).booth_number
  end

end