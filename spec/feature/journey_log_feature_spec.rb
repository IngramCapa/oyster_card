require 'journey_log'
require 'journey'
require 'station'

context "Interacting with JourneyLog" do
  specify "journey log can start and finish journeys" do
    journey_log = JourneyLog.new

    station1 = Station.new("Station 1", 1)
    expect(journey_log.start(station1)).to eq 0

    expect(journey_log.in_journey?).to eq true
    expect(journey_log.size).to eq 1

    station2 = Station.new("Station 2", 1)
    expect(journey_log.finish(station2)).to eq Journey::MINIMUM_FARE

    expect(journey_log.in_journey?).to eq false
    expect(journey_log.size).to eq 1
  end

  specify "penalty fares" do
    journey_log = JourneyLog.new

    station1 = Station.new("Station 1", 1)
    expect(journey_log.finish(station1)).to eq Journey::PENALTY_FARE
    expect(journey_log.in_journey?).to eq false
    expect(journey_log.size).to eq 1

    station2 = Station.new("Station 2", 1)
    journey_log.start(station2)
    expect(journey_log.size).to eq 2
    expect(journey_log.start(station1)).to eq Journey::PENALTY_FARE
    expect(journey_log.size).to eq 3
  end
end
