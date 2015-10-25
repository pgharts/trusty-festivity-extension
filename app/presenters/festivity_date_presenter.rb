class FestivityDatePresenter < FestivityDatetimePresenter

  def display
    @datetime.strftime("%a, %B %-d")
  end

end