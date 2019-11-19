require "oystercard"

describe OysterCard do

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
    expect(subject.in_journey).to eq false
  end

  describe "#touch_in" do

    it "should be able to touch in" do
      subject.top_up(5)
      subject.touch_in
      expect(subject.in_journey).to eq true
    end

    it "should raise an error if the min balance is not met" do
      oystercard = OysterCard.new
      expect{ oystercard.touch_in }.to raise_error "Insufficient money to touch in"
    end
  
  end

  describe "#touch_out" do
    before do
      subject.top_up(5)
    end

    it "should be able to touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end

    it "should be able to deduct money on touch out" do
      minimum_balance = OysterCard::MINIMUM_BALANCE
      expect{ subject.touch_out }.to change { subject.balance }.by (- minimum_balance)
    end
  end
end
