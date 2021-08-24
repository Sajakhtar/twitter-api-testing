load 'vars.rb'

require 'json'
require 'open-uri'
require 'rest-client'

# call coinggecko api coins list



key = COINMARKETCAP_KEY
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"


response = RestClient.get url
results = JSON.parse(response)
data = results['data']




data.map! do |crypto|
  # find coingecko coin id
  # call coingecko api for coin
    # get url
  # set cashtag $symbol
end
