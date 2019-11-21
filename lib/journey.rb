class Journey 

  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  @@journey_id = 0

  def initialize(station = nil)
    @info = {entry_station: station, exit_station: nil, fare: PENALTY_FARE}
    @@journey_id += 1
  end

  def end_journey(station = nil)
    @info[:exit_station] = station
    @info[:fare] = MINIMUM_FARE if @info[:exit_station] != nil && @info[:entry_station] != nil
    self
  end

  def in_journey?
    !!@info[:entry_station]
  end

  def fare
    @info[:fare]
  end

  def journey_id
    @@journey_id
  end
end