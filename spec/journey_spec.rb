require 'journey'

describe Journey do

  # it "should have a name" do
  #   expect(subject).to respond_to(:fare) 
  # end

  let(:entry_station) { double(:entry_station) }

  before do 
    allow(entry_station).to receive(:name) {"holburn"}
    allow(entry_station).to receive(:zone) {1}
  end

  # it "should intitially not be on a journey" do 
  #   expect(subject.in_journey).to eq false
  # end

  # it "should be in a journey after tapping in" do
  #   expect(subject.in_journey).to eq(true)
  # end

  it "knows if a journey is not complete" do
    expect(subject.complete?).to eq(false)
  end
  
end