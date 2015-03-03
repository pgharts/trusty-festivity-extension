class FestivityLocationPage < Page
  has_many :festivity_performances, foreign_key: :location_page_id
end