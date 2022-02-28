class Oystercard
  attr_accessor :balance
  attr_reader :travelling
  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(balance = 0)
    @balance = balance
    @travelling = false
  end

  def top_up(money)
    raise "exceeds £#{DEFAULT_MAX} balance limit" if @balance + money > DEFAULT_MAX
    @balance += money
  end
  
  def fare(cost)
    raise "insufficient funds" if @balance - cost < DEFAULT_MIN
    @balance -= cost
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  def in_journey?
    @travelling
  end
end
