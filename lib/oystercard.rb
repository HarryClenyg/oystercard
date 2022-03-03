class Oystercard
  attr_accessor :balance
  attr_reader :journey
  
  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(balance = 10, journey)
    @balance = balance
    @journey = journey
    @journeys = {}
    @journey_counter = 1
  end

  def on_entry(entry_station)
    check_journey
    check_balance
    @journey.touch_in(entry_station)
  end
  
  def on_exit(exit_station)
    @journey.touch_out(exit_station)
    add_journey
    fare
    @journey_counter += 1
  end

  def top_up(money)
    raise "exceeds £#{DEFAULT_MAX} balance limit" if @balance + money > DEFAULT_MAX
    @balance += money
  end

  
  private

  def add_journey
    @journeys["journey_#{@journey_counter}"] = journey.current_journey  
  end

  def check_balance
    raise "insufficient funds" if @balance - DEFAULT_MIN < DEFAULT_MIN
  end

  def check_journey
    on_exit(nil) if @journey.in_journey?
  end

  def fare
    @balance -= @journey.charge(@journeys["journey_#{@journey_counter}"])
  end

end
