# Preview all emails at http://localhost:3000/rails/mailers/alert_mailer
class AlertMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/alert_mailer/triggered
  def triggered
    AlertMailer.triggered
  end
end
