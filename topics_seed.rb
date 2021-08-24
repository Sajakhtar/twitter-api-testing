load 'vars.rb'

require 'json'
require 'open-uri'
require 'rest-client'

# call coinggecko api coins list
coingecko_response = RestClient.get 'https://api.coingecko.com/api/v3/coins/list'
coingecko_results = JSON.parse(coingecko_response)


key = COINMARKETCAP_KEY
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"


coinmarketcap_response = RestClient.get url
coinmarketcap_results = JSON.parse(coinmarketcap_response)
data = coinmarketcap_results['data']


data.map! do |crypto|
  # find coingecko coin id
# crypto["coin_id"] = coingecko_results.find { |coin| coin[] == crypto["symbol"] }
  # call coingecko api for coin
    # get url
  # set cashtag $symbol
  coin_url = "https://api.coingecko.com/api/v3/coins/#{coin_id}"
  # IMAGE:THUMB, NAME, SYMBOL, DESCRIPTION, LINKS, MARKET_DATE:CURRENT_PRICE:USD
end
