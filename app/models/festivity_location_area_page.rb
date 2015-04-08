class FestivityLocationAreaPage < Page
  def body
    self.part("body").content.html_safe
  end
end