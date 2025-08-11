desc "Fetch available symbols"
task fetch_available_symbols: [ :environment ] do
  puts "Fetch available symbols from Binance"

  HTTP.get("https://api.binance.com/api/v3/exchangeInfo")
    .then { it.parse }
    .then { it["symbols"] }
    .then do
      it.map do |symbolInfo|
        {
          value: symbolInfo["symbol"],
          display: symbolInfo["baseAsset"] + "->" + symbolInfo["quoteAsset"]
        }
      end
    end
    .then do
      file = Rails.root.join("lib", "available_symbols.json")
      json = JSON.pretty_generate(it)
      File.open(file, "w") do |file|
        file.write(json)
      end
    end
end
