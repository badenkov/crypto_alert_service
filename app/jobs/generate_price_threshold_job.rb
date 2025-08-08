class GeneratePriceThresholdJob < ApplicationJob
  queue_as :default

  def perform(alert)
    price_threshold = if alert.up?
                        current_price(alert.symbol) + alert.threshold
    else
                        current_price(alert.symbol) - alert.threshold
    end

    alert.update_columns(price_threshold: price_threshold, status: :active)
  end

  private

    def current_price(symbol)
      Binance.api_client.fetch_price(symbol: symbol).parse["price"].to_d
    end
end
