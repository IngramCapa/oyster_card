require 'journey'

describe Journey do

  # it "should have a name" do
  #   expect(subject).to respond_to(:fare) 
  # end

  it "should have nil entry station if initialised without a argument" do
    journey = Journey.new
    expect(journey.entry_station).to eq(nil)
  end

  let(:station) { double(:station) }
  
  subject {described_class.new(station)}

  it "knows if a journey is not complete" do
    expect(subject.in_journey?).to eq(true)
  end

  it "has a penatly fare by default" do 
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  context 'given an entry station' do
  
    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it "gives a penalty fare when there is no exit station" do 
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    context "given an exit station" do
      let(:station2) { double(:station2) }
      before do
        subject.end_journey(station2)
      end

      it "has an exit station" do
        expect(subject.exit_station).to eq(station2)
      end

      it 'calculates the correct fare' do
        expect(subject.fare).to eq(Journey::MINIMUM_FARE)
      end
    end
  end
end
