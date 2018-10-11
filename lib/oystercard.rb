require 'journey'

class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 1


  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @current_journey
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum limit (£#{MAX_BALANCE}) exceeded" if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station)
    deduct(current_journey.fare) if in_journey?
    raise "Not enough money on card" if @balance < MIN_BALANCE
    current_journey.start(station)

    #@entry_station = station.name
  end

  def touch_out(station)
    current_journey.finish(station)
    deduct(current_journey.fare)
    journey_log
  end

  def journey_log
    print current_journey
    @journey_history << current_journey.journey_info
    @current_journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def current_journey
    @current_journey ||= Journey.new
  end

end
