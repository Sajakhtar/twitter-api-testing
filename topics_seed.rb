load 'vars.rb'

require 'json'
require 'open-uri'
require 'rest-client'

# call coinggecko api coins list
coingecko_response = RestClient.get 'https://api.coingecko.com/api/v3/coins/list'
coingecko_results = JSON.parse(coingecko_response)


key = COINMARKETCAP_KEY
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=100"


coinmarketcap_response = RestClient.get url
coinmarketcap_results = JSON.parse(coinmarketcap_response)
data = coinmarketcap_results['data']


data.map! do |crypto|
  coingecko_coin_data= coingecko_results.find { |coin| coin["symbol"] == crypto["symbol"].downcase or coin["symbol"] == crypto["symbol"]}
  crypto["coingecko_id"] = coingecko_coin_data['id']
  p crypto["coingecko_id"]

  # coinggecko_coin_endpoint = "https://api.coingecko.com/api/v3/coins/#{crypto["coingecko_id"]}"
  # coingecko_coin_response = RestClient.get coinggecko_coin_endpoint
  # coingecko_coin_results = JSON.parse(coingecko_coin_response)

  # crypto["coingecko_icon_url"] =  coingecko_coin_results["image"]["thumb"]

  # crypto["cashtag"] = "$#{crypto["symbol"]}"

  crypto
end


# p data
