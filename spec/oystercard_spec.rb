require "oystercard.rb"

describe OysterCard do

  let(:station) {double :station, name: :aldgate}
  let(:station1) {double :station, name: :euston}
  let(:station2) {double :station, name: :kilburn}

  describe '#balance' do
    it { expect(subject.balance).to eq 0 }
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should top up balance by 5" do
      expect{subject.top_up(5)}.to change{subject.balance}.by 5
    end

    it "raise an error if maximum limit is exceeded" do
      max_balance = described_class::MAX_BALANCE
      expect{subject.top_up(max_balance + 1)}
      .to raise_error "Maximum limit (£#{max_balance}) exceeded"
    end

  end

  describe '#in_journey?' do
    it 'newly created card in not in journey' do
      expect(subject).not_to be_in_journey
    end
  end


  describe '#touch_out' do
    it "allows touch out to end a journey" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "raises if balance is below the minimum balance on touch in" do
      expect{subject.touch_in(station)}.to raise_error "Not enough money on card"
    end
  end

  describe '#journey_log' do
    it "records the entry station and exit station of a journey" do
      card = OysterCard.new
      card.top_up(10)
      card.touch_in(station1)
      card.touch_out(station2)
      expect(card.journey_log).to eq [{entry: station1.name, exit: station2.name }]
    end
  end

  describe 'oystercard feature test' do
    context 'has £5 on card and touches in' do


      before do
        subject.top_up(5)
        subject.touch_in(station)
      end

      it "allows touch in to start a journey" do
        expect(subject).to be_in_journey
      end

      it 'deducts minimum charge from card on touch out' do
        min_fare = described_class::MIN_FARE
        expect {subject.touch_out(station)}.to change{subject.balance}.by -min_fare
      end

      it 'stores entry station when touched in' do
        expect(subject.entry_station).to eq :aldgate
      end
    end

  end
end
