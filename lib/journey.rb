class Journey

  attr_reader :station
  attr_reader :journey_counter

  def initialize()
    @entry_station = nil
    @exit_station = nil
  end

  def touch_in(entry_station)
    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    @exit_station = exit_station
    @entry_station = nil
  end
  
  def current_journey
    [@entry_station, @exit_station]
  end
  
  def in_journey?
    @entry_station != nil
  end

  def charge(latest_journey)
    p latest_journey
    return 6 if latest_journey[1] == nil || latest_journey[0] == nil
    1
  end

end
