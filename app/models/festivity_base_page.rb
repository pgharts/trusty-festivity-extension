class FestivityBasePage < Page

  def body
    self.part("body").content.html_safe
  end

  def sponsor_logo
    self.part("sponsor_logo").content.html_safe
  end

  def sponsor_logo?
    !self.part("sponsor_logo").empty?
  end

  def video
    self.part("video").content.html_safe
  end

  def video?
    !self.part("video").empty?
  end

end