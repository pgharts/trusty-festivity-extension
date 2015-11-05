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

end