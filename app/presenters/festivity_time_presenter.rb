class FestivityTimePresenter < FestivityDatetimePresenter

  def display
    "#{display_start_time} - #{display_end_time}"
  end

  private

  def display_start_time
    @datetime.strftime(display_format)
  end

  def display_end_time
    (@datetime + 1.hour).strftime(display_format)
  end

  def display_format
    "%l:%M %P"
  end

end