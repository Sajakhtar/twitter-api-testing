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

# query = '"Bitcoin" "$BT C" lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'
query = '("Ethereum" OR "$ETH") lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)'

#######
# Do we need to append "#{query} crypto" OR "#{query} blockchain" to every query?
#######

##### ADD
#-is:nullcast
# Created_at date today using start_time YYYY-MM-DDTHH:mm:ssZ (ISO 8601/RFC 3339)
# since_id - returns results with a Tweet ID greater than (that is, more recent than) the specified ID. overrides start_time

# Add or remove parameters below to adjust the query and response fields within the payload
# See docs for list of param options: https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent

query_params = {
  "query": query, # Required
  "max_results": 100,
  # "start_time": "2021-08-24T00:00:00Z", # TRY WITH RUBY DATE
  "start_time": Date.today.strftime("%Y-%m-%dT%H:%M:%SZ"),
  # "end_time": "2020-07-02T18:00:00Z",
  "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
  "tweet.fields": "attachments,author_id,conversation_id,created_at,entities,id,lang,public_metrics,source,text,context_annotations,possibly_sensitive,withheld,geo,referenced_tweets",
  "user.fields": "name,location,description,public_metrics,url,username,verified,withheld,protected,profile_image_url",
  "media.fields": "url"
  # "place.fields": "country_code",
  # "poll.fields": "options"
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
users = result["includes"]['users']

tweets.map do |tweet|
  author = users.find { |user| user['id'] == tweet['author_id']}
  tweet['user'] = author
  tweet
end

tweets.select! { |tweet| tweet['user']["public_metrics"]["followers_count"] > 1000  }

tweets.sort! { |a,b| b['user']["public_metrics"]["followers_count"] <=> a['user']["public_metrics"]["followers_count"]}

tweets.first(10)

# tweets.each { |tw| p tw['username']}

# p tweets[0]


p tweets.size
# p tweets[0]
p tweets.first(10)
