require 'journey.rb'

describe Journey do

  describe '#start' do
    it "records the entry station" do
      journey = Journey.new
      journey.start("station")
      expect(journey.entry_station).to eq "station"
    end
  end

  describe '#finish' do
    it "records the exit station" do
      journey = Journey.new
      journey.start("station")
      journey.finish("station2")
      expect(journey.exit_station).to eq "station2"
    end
  end

  describe '#fare' do
    it "returns the minimum fare" do
      journey = Journey.new
      journey.start("station")
      journey.finish("station2")
      expect(journey.fare).to eq 1
    end

    it "returns the penalty fare" do
      journey = Journey.new
      journey.finish("station2")
      expect(journey.fare).to eq 6
    end
  end

  describe '#journey_complete?' do
    it "returns the penalty fare" do
      journey = Journey.new
      journey.finish("station2")
      expect(journey.journey_complete?).to eq false
    end
  end

end
