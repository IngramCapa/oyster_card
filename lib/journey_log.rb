class JourneyLog
  def initialize journey_class = Journey
    @journeys = []
    @journey_class = journey_class
    @in_journey = false
  end

  def size
    @journeys.size
  end

  def start station
    fare = @in_journey ? @journeys.last.fare : 0
    @journeys << @journey_class.new(station)
    @in_journey = true
    fare
  end
  
  def finish station
    @journeys << @journey_class.new unless @in_journey

    @journeys.last.end_journey(station)
    @in_journey = false
    @journeys.last.fare
  end

  def in_journey?
    @in_journey
  end
end
