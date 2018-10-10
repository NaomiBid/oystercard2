require 'journey'

class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 3


  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
    @exit_station
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum limit (£#{MAX_BALANCE}) exceeded" if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise "Not enough money on card" if @balance < MIN_BALANCE
    @new_journey = Journey.new
    @new_journey.start(station)
    @in_journey = true
    #@entry_station = station.name
  end

  def touch_out(station)
    @new_journey ||= Journey.new
    @new_journey.finish(station)
    @in_journey = false
    deduct(MIN_FARE)
    @exit_station = station.name
    journey_log
  end

  def journey_log
    print @new_journey
    @journey_history << @new_journey.journey_info
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
