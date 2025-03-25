require "net/http"
require "json"

module LatestStockPrice
  BASE_URL = "https://latest-stock-price.p.rapidapi.com"
  HEADERS = {
    "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com",
    "X-RapidAPI-Key" => "YOUR_RAPIDAPI_KEY" # Change with your API key
  }

  def self.fetch(endpoint, params = {})
    uri = URI("#{BASE_URL}/#{endpoint}")
    uri.query = URI.encode_www_form(params) if params.any?

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri, HEADERS)
      http.request(request)
    end

    JSON.parse(response.body)
  rescue StandardError => e
    { error: e.message }
  end

  def self.price(symbol)
    fetch("price", Identifier: symbol)
  end

  def self.prices(symbols)
    fetch("prices", Identifier: symbols)
  end

  def self.price_all
    fetch("price_all")
  end
end
