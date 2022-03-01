require 'station'

describe Station do
  subject { Station.new(name, zone) }
  let(:name) {'default_station'}
  let(:zone) {'default_zone'}
  it 'creates a station' do
  expect(subject).to be_a Station
  end
end
