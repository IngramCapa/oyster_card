class Journey 
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize(station = nil)
    @entry_station = station
    @fare = PENALTY_FARE
  end

  def end_journey(station)
    
    @exit_station = station
    @fare = MINIMUM_FARE if @entry_station != nil
    
  end

  def in_journey?
    !!@entry_station
  end
end
