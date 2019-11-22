require "oystercard"

describe OysterCard do

  let(:journey) { double :journey, in_journey?: true, end_journey: nil, fare: 1}  # this is our fake journey instance with their return values
  let(:journey_class) {double :journey_class, new: journey} # this creates our fake Journey class

  subject { OysterCard.new journey_class}

  describe "#balance" do

    it "has an initial balance" do
      expect(subject.balance).to eq(0)
    end

  end

  describe "#top_up" do

    it "should be able to increase the balance by 1" do
      expect{ subject.top_up(1) }.to change { subject.balance }.by 1
    end

    it "should raise an error if max balance is exceeded" do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of £#{maximum_balance} exceeded"
    end
  end

  it "should initially not be on a journey" do
    expect(subject.in_journey?).to eq false
  end

  context "using the card" do

    before do
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
    end

    let(:entry_station) { double(:entry_station) }
    let(:exit_station) { double(:exit_station)}
    
    describe "#touch_in" do
      
      
      it "should be able to touch in" do
        subject.touch_in(entry_station)
        expect(subject.in_journey?).to eq true
      end

      it "should raise an error if the min balance is not met" do
        oystercard = OysterCard.new
        expect{ oystercard.touch_in(entry_station) }.to raise_error "Insufficient money to touch in"
      end
    end

    describe "#touch_out" do

      it "should be able to touch out" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq false
      end

      it "should be able to deduct money on touch out" do
        expect{ subject.touch_out(exit_station) }.to change { subject.balance }.by -1
      end
    end
  end

  describe "#journey" do

    before do
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
    end

    let(:entry_station) { double(:entry_station) }
    let(:exit_station) { double(:exit_station)}

    it "should store one journey" do # to be removed upon creation of journeylog
      subject.touch_in(entry_station)
      allow(journey).to receive(:fare).and_return 1
      subject.touch_out(exit_station)
      #the journey arg below is the double 
      expect(subject.journey_history).to include(journey)
    end
  end

end
