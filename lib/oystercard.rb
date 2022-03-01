class Oystercard
  attr_accessor :balance
  attr_reader :journeys
  
  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(balance = 10)
    @balance = balance
    @journeys = Journey.new
  end

  def on_entry(entry_station)
    check_journey
    check_balance
    @journeys.touch_in(entry_station)
  end
  
  def on_exit(exit_station)
    @journeys.touch_out(exit_station)
    fare
  end
  

  def top_up(money)
    
    raise "exceeds £#{DEFAULT_MAX} balance limit" if @balance + money > DEFAULT_MAX
    @balance += money
  end

  def check_journey
    on_exit("n/a") if @journeys.in_journey?
  end

  def check_balance
    raise "insufficient funds" if @balance - DEFAULT_MIN < DEFAULT_MIN
  end
  
  private
  def fare
    
    @balance -= @journeys.charge(@journeys.journeys["journey_#{@journeys.journey_counter-1}"])
  end

end
