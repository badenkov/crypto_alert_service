class AlertMailer < ApplicationMailer
  def triggered
    mail(to: "user@example.test", subject: "Alert has been triggered")
  end
end
