class AlertWebhookNotifier < ApplicationNotifier
  self.driver = proc do |data|
    data => { body: , url: }
    next if url.blank?

    HTTP.post(url, json: body)
  end

  def triggered
    params => { alert: }

    notification(
      body: {
        alert: {
          id: alert.id,
          symbol: alert.symbol,
        }
      },
      url: alert.webhook_url
    )
  end
end
