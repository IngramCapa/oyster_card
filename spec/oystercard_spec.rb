require "oystercard"

describe OysterCard do

  describe "#balance" do
    it "has an initial balance" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should be able to increase the balance by 1" do
      expect{ subject.top_up(1) }.to change { subject.balance }.by 1
    end

    it "should raise an error if max balance is exceeded" do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "should be able to deduct an amount from the balance" do
      subject.top_up(3)
      expect{ subject.deduct 1 }.to change { subject.balance }.by -1
    end

    # it "should raise an error if the balance goes negative" do
    #   subject.top_up(3)
    #   expect{ subject.deduct 3 }.to change { subject.balance }.by -3
    #   expect{ subject.deduct 1 }.to raise_error "Not enough money on the card, balance is #{balance}
    # end

  end

  it "should initially not be in a journey" do
    expect(subject).not_to be_in_journey
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }

    it "should be able to touch in" do
      subject.touch_in
      expect(subject.touch_in).to eq true
    end

  end




end
