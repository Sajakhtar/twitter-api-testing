require 'json'
require 'open-uri'
require 'rest-client'

topic_titles = %w(blockchain cryptocurrencies cryptocurrency crypto nft nonfungible tokens defi decentralized finance cefi centralized finance metaverse cdbc central bank digital currency stable coin)


'https://api.coingecko.com/api/v3/coins/list' # NAME & SYMBOL, ID
# "https://api.coingecko.com/api/v3/coins/#{ID}"  # IMAGE:THUMB, NAME, SYMBOL, DESCRIPTION, LINKS, MARKET_DATE:CURRENT_PRICE:USD
"https://api.coingecko.com/api/v3/global" # MARKET CAP
# p topic_titles


response = RestClient.get 'https://api.coingecko.com/api/v3/coins/list'
results = JSON.parse(response)

results2 = results.reject {|crypto| crypto["id"].include?("-")}

p results2.count
#4783

# sample = results[0,10]

# formatted = sample.map do |crypto|
#   "#{crypto['name']} $#{crypto['symbol']}"
# end

# p formatted
