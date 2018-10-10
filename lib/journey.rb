class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station
    @exit_station
  end

  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end

  def journey_complete?
    !!(@entry_station && @exit_station)
  end

  def journey_info
    {entry: @entry_station, exit: @exit_station}
  end

end
