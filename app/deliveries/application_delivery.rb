# In the base class, you configure delivery lines
class ApplicationDelivery < ActiveDelivery::Base
  self.abstract_class = true

  # register_line :mailer, ActiveDelivery::Lines::Mailer

  # Mailers are enabled by default, everything else must be declared explicitly

  # For example, you can use a notifier line (see below) with a custom resolver
  # (the argument is the delivery class)
  # register_line :sms, ActiveDelivery::Lines::Notifier,
  #   resolver: -> { _1.name.gsub(/Delivery$/, "SMSNotifier").safe_constantize } #=> PostDelivery -> PostSMSNotifier

  # Or you can use a name pattern to resolve notifier classes for delivery classes
  # Available placeholders are:
  #  - delivery_class — full delivery class name
  #  - delivery_name — full delivery class name without the "Delivery" suffix
  # register_line :webhook, ActiveDelivery::Lines::Notifier,
  #   resolver_pattern: "%{delivery_name}WebhookNotifier" #=> PostDelivery -> PostWebhookNotifier
end
