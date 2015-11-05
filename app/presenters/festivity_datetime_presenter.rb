class FestivityDatetimePresenter
  attr_reader :datetime

  def initialize(datetime)
    @datetime = datetime
  end

  def display_as_date
    @datetime.strftime("%a, %B %-d")
  end

  def to_s
    @datetime.to_s
  end

  def to_date
    @datetime.to_date
  end

  def display_as_time_range
    "#{display_start_time} - #{display_end_time}"
  end

  def display_start_time
    @datetime.strftime(display_time_format)
  end

  def display_end_time
    (@datetime + 1.hour).strftime(display_time_format)
  end

  def display_time_format
    "%l:%M %P"
  end

end