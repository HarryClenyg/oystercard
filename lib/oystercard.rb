class Oystercard
  attr_accessor :balance
  DEFAULT_LIMIT = 90
  def initialize
    @balance = 0
  end

  def top_up(money)
    
    raise "exceeds £#{DEFAULT_LIMIT} balance limit" if @balance + money > DEFAULT_LIMIT
    @balance += money

  end

end
