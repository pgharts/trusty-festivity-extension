class FestivityMarketPage < FestivityBasePage

  include Concerns::FestivityArtistMethods
  has_many :festivity_categories, through: :festivity_page_categories

end