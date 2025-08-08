class AlertMailer < ApplicationMailer

  def triggered
    p params
    mail(to: "someuser@example.tst", subject: "Alert has been triggered")
  end
end
