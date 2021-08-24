require 'json'
require 'open-uri'
require 'rest-client'

key = '328cd628-68a9-4568-83e9-5f16aa209cba'
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"


response = RestClient.get url
results = JSON.parse(response)

p results['data'].size

p results['status']

p results['data'][0]

# name symbol market_cap
# quote"=>{"USD"=>{"price"

{"timestamp"=>"2021-08-24T12:09:10.354Z", "error_code"=>0, "error_message"=>nil, "elapsed"=>42, "credit_count"=>1, "notice"=>nil, "total_count"=>6138}
{"id"=>1, "name"=>"Bitcoin", "symbol"=>"BTC", "slug"=>"bitcoin", "num_market_pairs"=>8895, "date_added"=>"2013-04-28T00:00:00.000Z", "tags"=>["mineable", "pow", "sha-256", "store-of-value", "state-channels", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "binance-labs-portfolio", "arrington-xrp-capital", "blockchain-capital-portfolio", "boostvc-portfolio", "cms-holdings-portfolio", "dcg-portfolio", "dragonfly-capital-portfolio", "electric-capital-portfolio", "fabric-ventures-portfolio", "framework-ventures", "galaxy-digital-portfolio", "huobi-capital", "alameda-research-portfolio", "a16z-portfolio", "1confirmation-portfolio", "winklevoss-capital", "usv-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "multicoin-capital-portfolio", "paradigm-xzy-screener"], "max_supply"=>21000000, "circulating_supply"=>18795968, "total_supply"=>18795968, "platform"=>nil, "cmc_rank"=>1, "last_updated"=>"2021-08-24T12:08:02.000Z", "quote"=>{"USD"=>{"price"=>49303.14659377711, "volume_24h"=>35084624864.09918, "percent_change_1h"=>0.06934076, "percent_change_24h"=>-2.12473027, "percent_change_7d"=>4.90295416, "percent_change_30d"=>43.76389793, "percent_change_60d"=>48.10777273, "percent_change_90d"=>22.94480045, "market_cap"=>926700365675.9436, "market_cap_dominance"=>43.2486, "fully_diluted_market_cap"=>1035366078469.32, "last_updated"=>"2021-08-24T12:08:02.000Z"}}}
