class Oystercard
  attr_accessor :balance
  attr_reader :travelling
  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(balance = 10)
    @balance = balance
    @travelling = false
  end

  def top_up(money)
    raise "exceeds £#{DEFAULT_MAX} balance limit" if @balance + money > DEFAULT_MAX
    @balance += money
  end
  
  
  def touch_in
    raise "insufficient funds" if @balance - DEFAULT_MIN < DEFAULT_MIN
    @travelling = true
  end
  
  def touch_out
    @travelling = false
    fare
  end
  
  def in_journey?
    @travelling
  end

private
  def fare
    @balance -= DEFAULT_MIN
  end
end
