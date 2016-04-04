class FestivityMarketPage < FestivityBasePage

  include Concerns::FestivityArtistMethods
  has_many :festivity_categories, through: :festivity_page_categories

  def area
    FestivityLocationAreaPage.find(area_id)
  end

end