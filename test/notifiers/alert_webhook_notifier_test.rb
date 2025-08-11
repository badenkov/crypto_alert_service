require "test_helper"

class AlertWebhookNotifierTest < ActiveSupport::TestCase
  setup do
    @alert = alerts(:ethusdt)
    @alert.update_columns(webhook_url: "https://webhook.test")
    stub_request(:any, @alert.webhook_url)
    AbstractNotifier.delivery_mode = :normal
  end

  teardown do
    AbstractNotifier.delivery_mode = :test
  end

  test "send notification to webhook url" do
    AlertWebhookNotifier.with(alert: @alert).triggered.notify_now

    assert_requested :post, @alert.webhook_url,
      body: {
        alert: {
          id: @alert.id,
          symbol: @alert.symbol
        },
      }.to_json
  end
end
