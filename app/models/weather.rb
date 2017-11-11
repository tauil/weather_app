class Weather
  class_attribute :api_key, :api_endpoint

  self.api_endpoint = ENV["API_ENDPOINT"] || "http://api.openweathermap.org"
  self.api_key = ENV["API_KEY"]

  def self.by_city_and_country(options)
    country_name = options[:country_name]
    city_name = options[:city_name]
    params = [city_name, country_name].join(',')
    path = "/data/2.5/weather?q=#{params}&appid=#{self.api_key}"
    endpoint = [self.api_endpoint, path].join
    uri = URI(endpoint)

    response = Net::HTTP.get(uri)
    JSON.parse(response, object_class: OpenStruct)
  end

end
