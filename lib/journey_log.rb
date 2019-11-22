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
    @journeys << @journey_class.new(station)
    @in_journey = true
    0
  end

  def in_journey?
    @in_journey
  end
end
