require "station.rb"

describe Station do

  it "creates a station instance that has a name and a zone" do
    station = Station.new('name', 1)
    expect(station.name).to eq 'name'
    expect(station.zone).to eq 1

  end




end
