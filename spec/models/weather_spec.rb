require 'rails_helper'

RSpec.describe Weather, type: :model do
  describe '.by_city_and_country' do
    let!(:params) { {city_name: 'Rio de Janeiro', country_name: 'Brazil'} }
    let!(:mocked_uri) { URI("#{described_class.api_endpoint}/data/2.5/weather?q=Rio%20de%20Janeiro,Brazil&appid=#{described_class.api_key}") }
    let!(:response_mock) { "{\"coord\":{\"lon\":-43.21,\"lat\":-22.9},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"},{\"id\":701,\"main\":\"Mist\",\"description\":\"mist\",\"icon\":\"50d\"}],\"base\":\"stations\",\"main\":{\"temp\":295.15,\"pressure\":1007,\"humidity\":88,\"temp_min\":295.15,\"temp_max\":295.15},\"visibility\":1200,\"wind\":{\"speed\":2.1,\"deg\":250},\"clouds\":{\"all\":90},\"dt\":1510423200,\"sys\":{\"type\":1,\"id\":4446,\"message\":0.003,\"country\":\"BR\",\"sunrise\":1510387324,\"sunset\":1510434728},\"id\":3451190,\"name\":\"Rio de Janeiro\",\"cod\":200}" }

    subject { described_class.by_city_and_country(params) }

    before do
      allow(Net::HTTP).to receive(:get).with(mocked_uri).and_return(response_mock)
    end

    it 'invokes Net::HTTP.get with URI' do
      expect(Net::HTTP).to receive(:get).with(mocked_uri).and_return(response_mock)
      subject
    end

    it 'parses JSON' do
      expect(JSON).to receive(:parse).with(response_mock, { object_class: OpenStruct } )
      subject
    end

    it 'returns OpenStruct object' do
      expect(subject).to be_a(OpenStruct)
    end
  end
end
