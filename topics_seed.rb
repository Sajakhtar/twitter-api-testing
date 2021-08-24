load 'vars.rb'

require 'json'
require 'open-uri'
require 'rest-client'


COINMARKETCAP_KEY


key = COINMARKETCAP_KEY
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"
