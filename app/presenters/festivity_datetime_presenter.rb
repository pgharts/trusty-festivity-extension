class FestivityDatetimePresenter

  def initialize(datetime)
    @datetime = datetime
  end

  def to_s
    @datetime.to_s
  end

end