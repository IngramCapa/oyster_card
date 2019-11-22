require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey, in_journey?: true, end_journey: nil, fare: 1} 
  let(:journey_class) {double :journey_class, new: journey} # this creates our fake Journey class
  let(:station) { double :station }
  subject { JourneyLog.new journey_class }

  it "should be empty when first initialised" do
    expect(subject.size).to eq 0
  end

  it "should not be in a journey when first initialised" do
    expect(subject.in_journey?).to eq false
  end

  describe "#start" do
    it "should return 0 if no journeys are currently active" do
      expect(subject.start(station)).to eq 0
    end

    it "should increase the size by one" do
      expect { subject.start station }.to change { subject.size }.by 1
    end

    it "should be in a journey" do
      subject.start station
      expect(subject.in_journey?).to eq true
    end

    it "should return a penalty fare if there is no exit station for previous journey" do
      allow(journey).to receive(:fare).and_return 6
      subject.start station
      expect(subject.start(station)).to eq 6
    end
  end

  describe "#finish" do
    it "should return a minimum fare at the end of the journey" do
      subject.start(station)
      expect(subject.finish(station)).to eq 1
    end

    it "should not be in a journey" do
      subject.start(station)
      subject.finish(station)
      expect(subject.in_journey?).to eq false
    end

    it "should return the penalty fare if there is no entry station" do
      allow(journey).to receive(:fare).and_return 6
      expect(subject.finish(station)).to eq 6
    end
  end
end
