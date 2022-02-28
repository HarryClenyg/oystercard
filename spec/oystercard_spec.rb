require 'oystercard'

describe Oystercard do
  it 'card holds money' do
    expect(subject.balance).to be_a Integer
  end

  it 'card can be topped up' do
    expect(subject.top_up(10)).to eq 10
  end

  it 'raises an error when balance exceeds £90 limit' do
    expect{ subject.top_up(91)}.to raise_error "exceeds £90 balance limit"
  end

  it 'deducts money from the balance' do
    expect{ subject.fare(3) }.to change{ subject.balance }.by -3
  end
end