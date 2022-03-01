class Journey

  attr_reader :station
  attr_reader :journeys
  attr_reader :journey_counter

  def initialize()
    @entry_station = nil
    @journeys = {}
    @journey_counter = 1
    
  end

  def touch_in(entry_station)
    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    @journeys["journey_#{@journey_counter}"] = [@entry_station, exit_station]
    @journey_counter += 1
    @entry_station = nil
  end
  
  def in_journey?
    @entry_station != nil
  end

  def charge(latest_journey)
    p latest_journey
    return 6 if latest_journey[1] == "n/a"
    1
  end

end
