class HomeController < ApplicationController
  def index
  end

  def weather
    @city_name = weather_params[:city_name]
    @country_name = weather_params[:country_name]
    @weather = Weather.by_city_and_country(weather_params)
  end

  private

  def weather_params
    params.require(:weather).permit(:city_name, :country_name)
  end
end
