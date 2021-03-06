load 'vars.rb'

# This script uses your bearer token to authenticate and make a Search request

require 'date'

require 'json'
require 'typhoeus'

# The code below sets the bearer token from your environment variables
# To set environment variables on Mac OS X, run the export command below from the terminal:
# export BEARER_TOKEN='YOUR-TOKEN'
# bearer_token = ENV["BEARER_TOKEN"]
bearer_token = BEARER_TOKEN

# Endpoint URL for the Recent Search API
search_url = "https://api.twitter.com/2/tweets/search/recent"

# Set the query value here. Value can be up to 512 characters
# query = "from:Twitter OR from:TwitterDev OR from:DailyNasa"
# query = "from:CoinDesk"
# has:cashtags is premium
# has:mentions
# query = '"bitcoin" lang:en (has:media OR has:links OR has:hashtags OR has:videos)'
# query = 'bitcoin lang:en (has:media OR has:links OR has:hashtags OR has:videos)'
# query = 'btc lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos)'
# query = 'stx lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos)'
# query = '"$flow" lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos)'
# query = '"flow blockchain" lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
# query = '"dubai crypto" lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
# query = 'ethereum lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
# query = 'nft lang:en is:verified (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions) (-is:quote OR -is:reply OR -is:retweet)'
# do no negate in parenthesis with OR


# hashtag
# query = '"#nft" lang:en is:verified -is:retweet -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'

# cashtag
# query = '"$btc" lang:en is:verified -is:retweet -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'

# keyword
# query = 'nft lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'

# query = '"Bitcoin" "$BTC" lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
# query = '("Ethereum" OR "$ETH") lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
query = '("Bitcoin" OR "$BTC") lang:en is:verified'
# query = '("Ethereum" OR "$ETH") lang:en is:verified'
# query = '("Flow" OR "$FLOW") lang:en is:verified'
# query = '("Cardano" OR "$ADA") lang:en is:verified'
# query = '("Stacks" OR "$STX") lang:en is:verified'
# query = '"blockchain" lang:en is:verified'
# query = '("blockchain") lang:en is:verified'
# query = '"NFT" lang:en is:verified' #- SAME AS BELOW
# query = '("NFT") lang:en is:verified'
# query = '"Bitcoin" OR "$BTC" lang:en is:verified' #- NEED PARENTHESIS
# query = '"$BTC" lang:en is:verified'
# query = '"$FLOW" lang:en is:verified'
# query = '"$STX" lang:en is:verified' #- NOT WORKING
# query = '"$ADA" lang:en is:verified'
# query = '"$DOT" lang:en is:verified'
# query = '"$NEAR" lang:en is:verified'
# query = '"$DOGE" lang:en is:verified'
# query = '"$AXS" lang:en is:verified'
# query = '$BTC lang:en is:verified' - CASHTAG ONLY AVAILBLE OFR ADVANVED TIER
# query = '("Bitcoin" OR "$BTC" OR #btc OR #bitcoin OR #crypto) lang:en is:verified'
# query = '("Stacks" OR "$STX" OR #stx OR #stacks) lang:en is:verified'
# query = '("Stacks" OR "$STX" OR #stx OR #stacks) lang:en'
# query = '("Bitcoin" OR "$BTC" OR #btc OR #bitcoin OR #crypto) lang:en'

#######
# Do we need to append "#{query} crypto" OR "#{query} blockchain" to every query?
#######

##### ADD
#-is:nullcast
# Created_at date today using start_time YYYY-MM-DDTHH:mm:ssZ (ISO 8601/RFC 3339)
# since_id - returns results with a Tweet ID greater than (that is, more recent than) the specified ID. overrides start_time

# Add or remove parameters below to adjust the query and response fields within the payload
# See docs for list of param options: https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent

# query_params = {
#   "query": query, # Required
#   "max_results": 100,
#   # "start_time": "2021-08-24T00:00:00Z", # TRY WITH RUBY DATE
#   "start_time": Date.today.strftime("%Y-%m-%dT%H:%M:%SZ"),
#   # "end_time": "2020-07-02T18:00:00Z",
#   "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
#   "tweet.fields": "attachments,author_id,conversation_id,created_at,entities,id,lang,public_metrics,source,text,context_annotations,possibly_sensitive,withheld,geo,referenced_tweets",
#   "user.fields": "name,location,description,public_metrics,url,username,verified,withheld,protected,profile_image_url",
#   "media.fields": "url"
#   # "place.fields": "country_code",
#   # "poll.fields": "options"
# }

query_params = {
  "query": query, # Required
  "max_results": 100,
  "start_time": Date.today.strftime("%Y-%m-%dT%H:%M:%SZ"),
  "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
  "tweet.fields": "author_id,created_at,entities,id,lang,public_metrics,source,text,context_annotations,possibly_sensitive,withheld",
  "user.fields": "public_metrics,url,username,verified,withheld,protected",
}

def search_tweets(url, bearer_token, query_params)
  options = {
    method: 'get',
    headers: {
      "User-Agent": "v2RecentSearchRuby",
      "Authorization": "Bearer #{bearer_token}"
    },
    params: query_params
  }

  request = Typhoeus::Request.new(url, options)
  response = request.run

  return response
end

response = search_tweets(search_url, bearer_token, query_params)
# puts response.code, JSON.pretty_generate(JSON.parse(response.body))
result = JSON.parse(response.body)

# puts response.code, JSON.pretty_generate(result['data'][0])

# puts response.code, JSON.pretty_generate(result["includes"]['users'][0])


tweets = result['data']
p tweets.size
users = result["includes"]['users']
# p users.size

tweets.map do |tweet|
  author = users.find { |user| user['id'] == tweet['author_id']}
  tweet['user'] = author
  tweet
end
p tweets.size

# tweets.select! { |tweet| tweet['user']["public_metrics"]["followers_count"] > 1000  }
# p tweets.size

tweets.sort! { |a,b| b['user']["public_metrics"]["followers_count"] <=> a['user']["public_metrics"]["followers_count"]}


# filter for "lang": "en"
tweets.select! { |tweet| tweet['lang'] == 'en' }
p tweets.size

# filter for "possibly_sensitive": false,
tweets.select! { |tweet| tweet['possibly_sensitive'] == false }
p tweets.size

puts "--------------"
tweets.each { |tw| p tw['user']["public_metrics"]["followers_count"] }

puts "--------------"
tweets.first(5).each { |tw| p tw['text'] }

# tweets.first(10)

# tweets.each { |tw| p tw['username']}

# p tweets[0]
# puts "--------------"
# puts JSON.pretty_generate(tweets[0])

# p tweets.size
# p tweets[0]
# p tweets.first(10)


# TO DO
# add Parenthesis around the keyword '("Bitcoin" OR "$BTC") lang:en is:verified'
# change query to lang en and verified only - '("NFT") lang:en is:verified'
# Remove >1000 followers filter
# Add filter for tweets.select! { |tweet| tweet['lang'] == 'en' }
# Add filter for tweets.select! { |tweet| tweet['possibly_sensitive'] == false }
