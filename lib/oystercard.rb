class Oystercard
  attr_accessor :balance
  attr_reader :travelling
  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
    @travelling = false
  end

  def top_up(money)
    raise "exceeds £#{DEFAULT_LIMIT} balance limit" if @balance + money > DEFAULT_LIMIT
    @balance += money
  end

  def fare(cost)
    @balance -= cost
    
    @balance
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
