module Binance
  def self.api_client
    @api_client ||= Binance::ApiClient.new
  end
end
