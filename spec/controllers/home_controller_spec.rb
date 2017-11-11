require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weather" do
    let!(:mocked_uri) { URI("#{Weather.api_endpoint}/data/2.5/weather?q=Rio%20de%20Janeiro,Brazil&appid=#{Weather.api_key}") }
    let!(:response_mock) { "{\"coord\":{\"lon\":-43.21,\"lat\":-22.9},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"},{\"id\":701,\"main\":\"Mist\",\"description\":\"mist\",\"icon\":\"50d\"}],\"base\":\"stations\",\"main\":{\"temp\":295.15,\"pressure\":1007,\"humidity\":88,\"temp_min\":295.15,\"temp_max\":295.15},\"visibility\":1200,\"wind\":{\"speed\":2.1,\"deg\":250},\"clouds\":{\"all\":90},\"dt\":1510423200,\"sys\":{\"type\":1,\"id\":4446,\"message\":0.003,\"country\":\"BR\",\"sunrise\":1510387324,\"sunset\":1510434728},\"id\":3451190,\"name\":\"Rio de Janeiro\",\"cod\":200}" }

    subject { get :weather, params: { weather: { city_name: 'Rio de Janeiro', country_name: 'Brazil' } } }

    before do
      allow(Net::HTTP).to receive(:get).with(mocked_uri).and_return(response_mock)
    end

    it "returns http success" do
      subject
      expect(response).to have_http_status(:success)
    end

    it "assigns @city_name" do
      subject
      expect(assigns(:city_name)).to eq('Rio de Janeiro')
    end

    it "assigns @country_name" do
      subject
      expect(assigns(:country_name)).to eq('Brazil')
    end

    it "assigns @weather" do
      subject
      expect(assigns(:weather)).to be_an_instance_of(OpenStruct)
      expect(assigns(:weather).weather.first.main).to eq('Rain')
      expect(assigns(:weather).weather.first.description).to eq('moderate rain')
    end
  end

end
