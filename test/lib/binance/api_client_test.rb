require "test_helper"

class Binance::ApiClientTest < ActiveSupport::TestCase
  setup do
    @client = Binance::ApiClient.new
  end

  test "fetch price" do
    VCR.use_cassette("fetch_price") do
      response = @client.fetch_price(symbol: "BTCUSDT")
      body = response.parse

      assert response.status.success?
      assert body.key?("symbol")
      assert body.key?("price")
      assert_equal "BTCUSDT", body["symbol"]
    end
  end

  test "fetch prices" do
    VCR.use_cassette("fetch_prices") do
      response = @client.fetch_prices(symbols: [ "BTCUSDT", "BNBUSDT" ])
      body = response.parse

      assert response.status.success?

      symbols = body.map { _1["symbol"] }
      assert_includes symbols, "BTCUSDT"
      assert_includes symbols, "BNBUSDT"
    end
  end
end
