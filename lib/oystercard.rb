class OysterCard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum limit (£#{MAX_BALANCE}) exceeded" if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey? 
    @in_journey
  end

end
