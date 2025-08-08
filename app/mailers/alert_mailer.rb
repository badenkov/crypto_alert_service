class AlertMailer < ApplicationMailer
  def triggered
    mail to: "user@example.test"
  end
end
