class FestivityLocationPage < Page
  has_many :festivity_performances, foreign_key: :location_page_id

  def body
    self.part("body").content.html_safe
  end
end