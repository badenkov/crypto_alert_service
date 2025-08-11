class AlertDelivery < ApplicationDelivery
  register_line :webhook, notifier: true, suffix: "WebhookNotifier"

  before_notify :ensure_required_params
  before_notify :ensure_mailer_enabled, on: :mailer
  before_notify :ensure_webhook_enabled, on: :webhook

  private

    def ensure_required_params
      raise "Alert required" if params[:alert].blank?
    end

    def ensure_mailer_enabled
      params[:alert].email_address.present?
    end

    def ensure_webhook_enabled
      params[:alert].webhook_url.present?
    end
end 
