require 'json'
require 'open-uri'
require 'rest-client'

key = '328cd628-68a9-4568-83e9-5f16aa209cba'
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"


response = RestClient.get url
results = JSON.parse(response)

# p results['data'].size

data = results['data']

# p results['status']

# p results['data'][0]

# name symbol market_cap
# quote"=>{"USD"=>{"price"

# {"timestamp"=>"2021-08-24T12:09:10.354Z", "error_code"=>0, "error_message"=>nil, "elapsed"=>42, "credit_count"=>1, "notice"=>nil, "total_count"=>6138}
# {"id"=>1, "name"=>"Bitcoin", "symbol"=>"BTC", "slug"=>"bitcoin", "num_market_pairs"=>8895, "date_added"=>"2013-04-28T00:00:00.000Z", "tags"=>["mineable", "pow", "sha-256", "store-of-value", "state-channels", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "binance-labs-portfolio", "arrington-xrp-capital", "blockchain-capital-portfolio", "boostvc-portfolio", "cms-holdings-portfolio", "dcg-portfolio", "dragonfly-capital-portfolio", "electric-capital-portfolio", "fabric-ventures-portfolio", "framework-ventures", "galaxy-digital-portfolio", "huobi-capital", "alameda-research-portfolio", "a16z-portfolio", "1confirmation-portfolio", "winklevoss-capital", "usv-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "multicoin-capital-portfolio", "paradigm-xzy-screener"], "max_supply"=>21000000, "circulating_supply"=>18795968, "total_supply"=>18795968, "platform"=>nil, "cmc_rank"=>1, "last_updated"=>"2021-08-24T12:08:02.000Z", "quote"=>{"USD"=>{"price"=>49303.14659377711, "volume_24h"=>35084624864.09918, "percent_change_1h"=>0.06934076, "percent_change_24h"=>-2.12473027, "percent_change_7d"=>4.90295416, "percent_change_30d"=>43.76389793, "percent_change_60d"=>48.10777273, "percent_change_90d"=>22.94480045, "market_cap"=>926700365675.9436, "market_cap_dominance"=>43.2486, "fully_diluted_market_cap"=>1035366078469.32, "last_updated"=>"2021-08-24T12:08:02.000Z"}}}


data.map! do |crypto|
  "#{crypto['name']} $#{crypto['symbol']}"
end

# p data
# p data.size

topic_titles = %w(blockchain cryptocurrencies cryptocurrency crypto nft nonfungible tokens defi decentralized finance cefi centralized finance metaverse cdbc central bank digital currency stable coin)


topic_titles += data

p topic_titles.size


p topic_titles


# ["blockchain", "cryptocurrencies", "cryptocurrency", "crypto", "nft", "nonfungible", "tokens", "defi", "decentralized", "finance", "cefi", "centralized", "finance", "metaverse", "cdbc", "central", "bank", "digital", "currency", "stable", "coin", "Bitcoin $BTC", "Ethereum $ETH", "Cardano $ADA", "Binance Coin $BNB", "Tether $USDT", "XRP $XRP", "Dogecoin $DOGE", "USD Coin $USDC", "Polkadot $DOT", "Solana $SOL", "Uniswap $UNI", "Terra $LUNA", "Chainlink $LINK", "Bitcoin Cash $BCH", "Binance USD $BUSD", "Litecoin $LTC", "Polygon $MATIC", "Internet Computer $ICP", "Wrapped Bitcoin $WBTC", "Stellar $XLM", "VeChain $VET", "Ethereum Classic $ETC", "Avalanche $AVAX", "Filecoin $FIL", "THETA $THETA", "TRON $TRX", "Dai $DAI", "Monero $XMR", "PancakeSwap $CAKE", "EOS $EOS", "Aave $AAVE", "The Graph $GRT", "FTX Token $FTT", "Cosmos $ATOM", "Axie Infinity $AXS", "Klaytn $KLAY", "Neo $NEO", "Crypto.com Coin $CRO", "Bitcoin BEP2 $BTCB", "Algorand $ALGO", "Maker $MKR", "Tezos $XTZ", "IOTA $MIOTA", "SHIBA INU $SHIB", "Bitcoin SV $BSV", "BitTorrent $BTT", "UNUS SED LEO $LEO", "Elrond $EGLD", "Dash $DASH", "Amp $AMP", "Kusama $KSM", "Waves $WAVES", "Hedera Hashgraph $HBAR", "Compound $COMP", "THORChain $RUNE", "NEAR Protocol $NEAR", "Huobi Token $HT", "Chiliz $CHZ", "Helium $HNT", "Decred $DCR", "TerraUSD $UST", "Quant $QNT", "XinFin Network $XDC", "Zcash $ZEC", "Holo $HOT", "NEM $XEM", "Stacks $STX", "Theta Fuel $TFUEL", "Decentraland $MANA", "Enjin Coin $ENJ", "SushiSwap $SUSHI", "Synthetix $SNX", "yearn.finance $YFI", "Telcoin $TEL", "TrueUSD $TUSD", "Zilliqa $ZIL", "Ravencoin $RVN", "Flow $FLOW", "Qtum $QTUM", "Celsius $CEL", "Fantom $FTM", "OKB $OKB", "Basic Attention Token $BAT", "Bitcoin Gold $BTG", "Harmony $ONE", "Audius $AUDIO", "Nexo $NEXO", "KuCoin Token $KCS", "Siacoin $SC", "DigiByte $DGB", "Ontology $ONT", "Arweave $AR", "Bancor $BNT", "Perpetual Protocol $PERP", "ICON $ICX", "0x $ZRX", "SwissBorg $CHSB", "Mdex $MDX", "OMG Network $OMG", "Paxos Standard $PAX", "Nano $NANO", "Revain $REV", "Horizen $ZEN", "Curve DAO Token $CRV", "Celo $CELO", "UMA $UMA", "Voyager Token $VGX", "Ankr $ANKR", "Swipe $SXP", "IoTeX $IOTX", "Dent $DENT", "renBTC $RENBTC", "Kava.io $KAVA", "IOST $IOST", "Reserve Rights $RSR", "Loopring $LRC", "Ren $REN", "Mina $MINA", "1inch $1INCH", "Ocean Protocol $OCEAN", "Lisk $LSK", "WAX $WAXP", "The Sandbox $SAND", "Ergo $ERG", "BakeryToken $BAKE", "WazirX $WRX", "WINkLink $WIN", "Verge $XVG", "VeThor Token $VTHO", "Bitcoin Diamond $BCD", "HUSD $HUSD", "Neutrino USD $USDN", "Livepeer $LPT", "Golem $GLM", "MediBloc $MED", "Constellation $DAG", "Numeraire $NMR", "Storj $STORJ", "Nervos Network $CKB", "Alpha Finance Lab $ALPHA", "SKALE Network $SKL", "Fei Protocol $FEI", "Unibright $UBT", "iExec RLC $RLC", "Fetch.ai $FET", "Ontology Gas $ONG", "FUNToken $FUN", "Gnosis $GNO", "Energy Web Token $EWT", "Origin Protocol $OGN", "Injective Protocol $INJ", "MyNeighborAlice $ALICE", "Venus $XVS", "Status $SNT", "Serum $SRM", "GateToken $GT", "Band Protocol $BAND", "ASD $BTMX", "WOO Network $WOO", "NKN $NKN", "StormX $STMX", "PAX Gold $PAXG", "Prometeus $PROM", "Reef $REEF", "Stratis $STRAX", "Augur $REP", "TomoChain $TOMO", "Cartesi $CTSI", "Ardor $ARDR", "Orchid $OXT", "Celer Network $CELR", "Bitcoin Standard Hashrate Token $BTCST", "COTI $COTI", "Conflux Network $CFX", "Request $REQ", "SingularityNET $AGIX", "MaidSafeCoin $MAID", "Civic $CVC", "DODO $DODO", "Badger DAO $BADGER", "Orbs $ORBS", "MVL $MVL", "Steem $STEEM", "Kin $KIN", "Ultra $UOS", "Phala Network $PHA", "Smooth Love Potion $SLP", "Hive $HIVE", "Polymath $POLY", "Aragon $ANT", "NuCypher $NU", "Balancer $BAL", "Metal $MTL", "Utrust $UTK", "BORA $BORA", "ZKSwap $ZKS", "Strike $STRK", "RSK Infrastructure Framework $RIF", "aelf $ELF", "Gemini Dollar $GUSD"]
