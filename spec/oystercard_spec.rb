require 'oystercard'


describe Oystercard do
  let(:station) { double :station }
  let(:journey) { double :journey }
  let(:subject) { Oystercard.new(10,journey)}

  it 'balance holds money' do
    expect(subject.balance).to be_a Integer
  end

  it 'card can be topped up' do
    expect(subject.top_up(10)).to eq 20
  end

  it 'raises an error when balance exceeds £90 limit' do
    expect{ subject.top_up(81)}.to raise_error "exceeds £90 balance limit"
  end

  it 'raises an error on_entry if balance is below £1 limit' do
    allow(journey).to receive(:in_journey?).and_return(false)
    card = Oystercard.new(0,journey)
    expect{ card.on_entry(station)}.to raise_error "insufficient funds"
  end
  
  xit 'deducts money from the balance' do
    allow(journey).to receive(:in_journey?).and_return(false)
    subject.on_entry(station)
    expect{ subject.on_exit(station) }.to change{ subject.balance }.by -Oystercard::DEFAULT_MIN
  end

end
  

