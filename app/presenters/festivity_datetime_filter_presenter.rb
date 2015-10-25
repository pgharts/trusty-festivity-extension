class FestivityDatetimeFilterPresenter

  def self.new(datetimes, datetime_type)
    datetimes.map { |datetime| datetime_type_class(datetime_type).new(datetime) }

  end

  private

  def self.datetime_type_class(datetime_type)
   datetime_type == "date" ? FestivityDatePresenter : FestivityTimePresenter
  end

end