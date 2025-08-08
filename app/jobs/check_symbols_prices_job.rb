class CheckSymbolsPricesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    symbols = Alert.distinct.pluck(:symbol)
    prices = Binance.api_client.fetch_prices(symbols:).parse

    conditions = prices.map do |s|
      symbol = s["symbol"]
      price = s["price"].to_d

      up_condition = Alert.where(symbol: symbol, direction: "up")
        .where("price_threshold < ? ", price)
      down_condition = Alert.where(symbol: symbol, direction: "down")
        .where("price_threshold > ?", price)

      up_condition.or(down_condition)
    end

    scope = conditions.reduce do |scope, condition|
      scope.or(condition)
    end

    alerts = Alert.active.merge(scope) || []

    alerts.each do |alert|
      # TODO send notification
      alert.completed!
    end
  end
end
