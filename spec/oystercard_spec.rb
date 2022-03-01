require 'oystercard'


describe Oystercard do
  let(:station) { double :station }
  
  it 'card holds money' do
    expect(subject.balance).to be_a Integer
  end

  it 'card can be topped up' do
    expect(subject.top_up(10)).to eq 20
  end

  it 'raises an error when balance exceeds £90 limit' do
    expect{ subject.top_up(91)}.to raise_error "exceeds £90 balance limit"
  end

  it 'raises an error when fare is charged and balance is below £1 limit' do
    card = Oystercard.new(0)
    expect{ card.touch_in(station)}.to raise_error "insufficient funds"
  end

  it 'deducts money from the balance' do
    card = Oystercard.new(10)
    card.touch_in(station)
    expect{ card.touch_out(station) }.to change{ card.balance }.by -Oystercard::DEFAULT_MIN
  end

  it 'touch_out deducts the minimum fare of £1' do
    card = Oystercard.new(10)
    expect{ card.touch_out(station) }.to change{ card.balance }.by -Oystercard::DEFAULT_MIN
  end

  it 'enables card to be touched in' do
    expect{ subject.touch_in(station)}.to change {subject.in_journey?}.to true
  end
  
  it 'enables card to be touched out' do
    subject.touch_in(station)
    expect{ subject.touch_out(station)}.to change {subject.in_journey?}.to false
  end
  
  it 'travelling should equal false' do
    expect(subject).not_to be_in_journey
  end
  
  it 'card can store entry station on touch in' do
    expect(subject.touch_in(station)).to eq station
  end
  
  it 'card can forgets entry station on touch out' do
    subject.touch_in(station)
    expect{ subject.touch_out(station)}.to change {subject.in_journey?}.to false
  end

  it 'card has empty list of journeys by default' do
    expect(subject.journeys).to eq({})
  end
  
  before do
    @picadilly, @moorgate = station, station
  end

  describe 'testing the @journeys instance variable' do

    it 'touch out will store a journey as an array within the 
    instance variable hash named journeys' do
      subject.touch_in(@picadilly)
      subject.touch_out(@moorgate)
      expect(subject.journeys).to eq({"journey_1"=>[@picadilly,@moorgate]})
    end

    it '@journeys can store multiple journeys' do
      3.times do
        subject.touch_in(@picadilly)
        subject.touch_out(@moorgate)
      end
      expect(subject.journeys.count).to eq 3
    end
  end

  describe 'accessing name/zone of saved journeys' do

    it 'returns the names of the stations' do
      allow(station).to receive(:name).and_return('picadilly', 'moorgate')

      subject.touch_in(@picadilly)
      subject.touch_out(@moorgate)
      expect(subject.journeys['journey_1'].map{ |station|
      station.name }).to eq (['picadilly', 'moorgate'])
      end
    end

    it 'returns the names of the zones' do
      allow(station).to receive(:zone).and_return(1, 1)

      subject.touch_in(@picadilly)
      subject.touch_out(@moorgate)
      expect(subject.journeys['journey_1'].map{ |station|
      station.zone }).to eq ([1, 1])
      end
    end
  

