class AlertDelivery < ApplicationDelivery
  register_line :webhook, notifier: true, suffix: "WebhookNotifier"
end
