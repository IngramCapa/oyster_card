require 'station'

describe Station do

  let(:subject) {Station.new("holborn", 1)}

  it "should have a name" do
    expect(subject).to respond_to(:name) 
  end

  it "should have a zone" do
    expect(subject).to respond_to(:zone) 
  end

end