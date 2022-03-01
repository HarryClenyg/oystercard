class Oystercard
  attr_accessor :balance
  attr_reader :station
  attr_reader :journeys

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(balance = 10)
    @journeys = {}
    @journey_counter = 1
    @entry_station = nil
    @balance = balance
  end

  def top_up(money)
    raise "exceeds £#{DEFAULT_MAX} balance limit" if @balance + money > DEFAULT_MAX
    @balance += money
  end
  
  
  def touch_in(entry_station)
    raise "insufficient funds" if @balance - DEFAULT_MIN < DEFAULT_MIN
    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    @journeys["journey_#{@journey_counter}"] = [@entry_station, exit_station]
    @journey_counter += 1
    fare
    @entry_station = nil
  end
  
  def in_journey?
    @entry_station != nil
  end

private
  def fare
    @balance -= DEFAULT_MIN
  end
end
