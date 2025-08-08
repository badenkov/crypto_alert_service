class Binance::ApiClient
  def fetch_price(symbol:)
    HTTP.get("https://api.binance.com/api/v3/ticker/price", params: { symbol: })
  end

  def fetch_prices(symbols:)
    HTTP.get("https://api.binance.com/api/v3/ticker/price", params: {
      symbols: symbols.to_json
    })
  end
end
